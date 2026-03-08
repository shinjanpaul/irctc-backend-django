import time
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from .models import Train, TrainClass
from .serializers import TrainSerializer, TrainClassSerializer
from .permissions import IsAdminUserCustom
from logs.mongo import search_logs


class TrainCreateUpdateView(APIView):
    permission_classes = [IsAdminUserCustom]

    def post(self, request):
        serializer = TrainSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class TrainClassCreateView(APIView):
    permission_classes = [IsAdminUserCustom]

    def post(self, request, train_id):
        try:
            train = Train.objects.get(id=train_id)
        except Train.DoesNotExist:
            return Response({"error": "Train not found"}, status=404)

        serializer = TrainClassSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(train=train)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class TrainSearchView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        start_time = time.time()

        source      = request.GET.get('source')
        destination = request.GET.get('destination')
        date        = request.GET.get('date')  # ✅ new optional param

        trains = Train.objects.filter(
            source__iexact=source,
            destination__iexact=destination
        ).prefetch_related('classes')

        # Pass date to serializer context so availability is date-specific
        serializer = TrainSerializer(trains, many=True, context={'date': date})

        execution_time = int((time.time() - start_time) * 1000)

        search_logs.insert_one({
            "user_id": request.user.id,
            "source": source,
            "destination": destination,
            "execution_time_ms": execution_time,
            "endpoint": "/api/trains/search/"
        })

        return Response(serializer.data)