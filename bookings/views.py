from django.db import transaction
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from trains.models import Train
from .models import Booking
from .serializers import BookingSerializer

class BookingCreateView(APIView):

    def post(self, request):
        train_id = request.data.get('train_id')
        seats_requested = int(request.data.get('seats'))

        with transaction.atomic():
            train = Train.objects.select_for_update().get(id=train_id)

            if train.available_seats < seats_requested:
                return Response(
                    {'error': 'Not enough seats available'},
                    status=status.HTTP_400_BAD_REQUEST
                )

            train.available_seats -= seats_requested
            train.save()

            booking = Booking.objects.create(
                user=request.user,
                train=train,
                seats_booked=seats_requested
            )

        serializer = BookingSerializer(booking)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
class MyBookingsView(APIView):

    def get(self, request):
        bookings = Booking.objects.filter(user=request.user).select_related('train')
        serializer = BookingSerializer(bookings, many=True)
        return Response(serializer.data)
