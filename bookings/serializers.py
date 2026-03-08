from rest_framework import serializers
from .models import Booking
from trains.models import Train, TrainClass


class TrainSerializer(serializers.ModelSerializer):
    class Meta:
        model = Train
        fields = ['id', 'name', 'source', 'destination']


class TrainClassSerializer(serializers.ModelSerializer):
    class_display = serializers.CharField(source='get_class_type_display', read_only=True)

    class Meta:
        model = TrainClass
        fields = ['id', 'class_type', 'class_display', 'price']


class BookingSerializer(serializers.ModelSerializer):
    train = TrainSerializer(read_only=True)
    train_class = TrainClassSerializer(read_only=True)

    class Meta:
        model = Booking
        fields = ['id', 'train', 'train_class', 'seats_booked', 'travel_date', 'booked_at']  # ✅ travel_date added