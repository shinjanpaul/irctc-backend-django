from rest_framework import serializers
from .models import Train, TrainClass, TrainAvailability


class TrainAvailabilitySerializer(serializers.ModelSerializer):
    class Meta:
        model = TrainAvailability
        fields = ['date', 'available_seats']


class TrainClassSerializer(serializers.ModelSerializer):
    class_display = serializers.CharField(source='get_class_type_display', read_only=True)
    available_for_date = serializers.SerializerMethodField()

    class Meta:
        model = TrainClass
        fields = ['id', 'class_type', 'class_display', 'total_seats', 'available_seats', 'price', 'available_for_date']

    def get_available_for_date(self, obj):
        date = self.context.get('date')
        if not date:
            return obj.total_seats
        try:
            av = TrainAvailability.objects.get(train_class=obj, date=date)
            return av.available_seats
        except TrainAvailability.DoesNotExist:
            return obj.total_seats


class TrainSerializer(serializers.ModelSerializer):
    classes = serializers.SerializerMethodField()  # ✅ changed from nested serializer

    class Meta:
        model = Train
        fields = ['id', 'train_number', 'name', 'source', 'destination',
                  'departure_time', 'arrival_time', 'classes']

    def get_classes(self, obj):
        # ✅ manually pass context down to TrainClassSerializer
        return TrainClassSerializer(
            obj.classes.all(),
            many=True,
            context=self.context  # ✅ this is the fix!
        ).data