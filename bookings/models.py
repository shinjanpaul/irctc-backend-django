from django.db import models
from django.conf import settings
from trains.models import Train, TrainClass

User = settings.AUTH_USER_MODEL

class Booking(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    train = models.ForeignKey(Train, on_delete=models.CASCADE)
    train_class = models.ForeignKey(TrainClass, on_delete=models.SET_NULL, null=True)
    seats_booked = models.PositiveIntegerField()
    travel_date = models.DateField()                    # ✅ NEW
    booked_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user} - {self.train} - {self.travel_date}"