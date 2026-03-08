import razorpay
import hmac
import hashlib
from django.conf import settings
from django.db import transaction
from rest_framework.views import APIView
from rest_framework.response import Response
from trains.models import Train, TrainClass, TrainAvailability
from .models import Booking
from .serializers import BookingSerializer

client = razorpay.Client(auth=(settings.RAZORPAY_KEY_ID, settings.RAZORPAY_KEY_SECRET))


class CreateOrderView(APIView):
    def post(self, request):
        train_id    = request.data.get("train_id")
        class_id    = request.data.get("class_id")
        seats       = int(request.data.get("seats", 1))
        travel_date = request.data.get("travel_date")

        if not travel_date:
            return Response({"error": "Travel date is required."}, status=400)

        try:
            train_class = TrainClass.objects.get(id=class_id, train_id=train_id)
        except TrainClass.DoesNotExist:
            return Response({"error": "Train class not found"}, status=404)

        # Get or create availability for this date
        availability, _ = TrainAvailability.objects.get_or_create(
            train_class=train_class,
            date=travel_date,
            defaults={'available_seats': train_class.total_seats}
        )

        if availability.available_seats < seats:
            return Response({"error": "Not enough seats available for this date."}, status=400)

        amount = int(train_class.price * seats * 100)

        order = client.order.create({
            "amount": amount,
            "currency": "INR",
            "payment_capture": 1,
        })

        return Response({
            "order_id": order["id"],
            "amount": amount,
            "currency": "INR",
            "key": settings.RAZORPAY_KEY_ID,
        })


class VerifyPaymentView(APIView):
    def post(self, request):
        razorpay_order_id   = request.data.get("razorpay_order_id")
        razorpay_payment_id = request.data.get("razorpay_payment_id")
        razorpay_signature  = request.data.get("razorpay_signature")
        train_id            = request.data.get("train_id")
        class_id            = request.data.get("class_id")
        seats               = int(request.data.get("seats", 1))
        travel_date         = request.data.get("travel_date")

        if not travel_date:
            return Response({"error": "Travel date is required."}, status=400)

        # Verify signature
        msg = f"{razorpay_order_id}|{razorpay_payment_id}"
        generated_signature = hmac.new(
            key=settings.RAZORPAY_KEY_SECRET.encode(),
            msg=msg.encode(),
            digestmod=hashlib.sha256
        ).hexdigest()

        if generated_signature != razorpay_signature:
            return Response({"error": "Payment verification failed!"}, status=400)

        try:
            with transaction.atomic():
                train_class = TrainClass.objects.get(id=class_id, train_id=train_id)

                # Get or create availability for this date
                availability = TrainAvailability.objects.select_for_update().get_or_create(
                    train_class=train_class,
                    date=travel_date,
                    defaults={'available_seats': train_class.total_seats}
                )[0]

                if availability.available_seats < seats:
                    return Response({"error": "Not enough seats available for this date."}, status=400)

                # Reduce seats only for this date
                availability.available_seats -= seats
                availability.save()

                booking = Booking.objects.create(
                    user=request.user,
                    train_id=train_id,
                    train_class=train_class,
                    seats_booked=seats,
                    travel_date=travel_date,
                )

            serializer = BookingSerializer(booking)
            return Response(serializer.data, status=201)

        except TrainClass.DoesNotExist:
            return Response({"error": "Train class not found"}, status=404)


class MyBookingsView(APIView):
    def get(self, request):
        bookings = Booking.objects.filter(user=request.user).select_related('train', 'train_class').order_by('-booked_at') 
        serializer = BookingSerializer(bookings, many=True)
        return Response(serializer.data)