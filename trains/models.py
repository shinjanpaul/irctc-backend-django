from django.db import models

class Train(models.Model):
    train_number = models.CharField(max_length=10, unique=True)
    name = models.CharField(max_length=100)
    source = models.CharField(max_length=50)
    destination = models.CharField(max_length=50)
    departure_time = models.TimeField()
    arrival_time = models.TimeField()

    def __str__(self):
        return f"{self.train_number} - {self.name}"


class TrainClass(models.Model):
    CLASS_CHOICES = [
        ('GEN', 'General'),
        ('SL', 'Sleeper'),
        ('3A', 'AC 3 Tier'),
        ('2A', 'AC 2 Tier'),
        ('1A', 'AC First Class'),
    ]

    train = models.ForeignKey(Train, on_delete=models.CASCADE, related_name='classes')
    class_type = models.CharField(max_length=5, choices=CLASS_CHOICES)
    total_seats = models.IntegerField()
    available_seats = models.IntegerField()  # default seats set by admin
    price = models.DecimalField(max_digits=8, decimal_places=2)

    class Meta:
        unique_together = ('train', 'class_type')

    def __str__(self):
        return f"{self.train.name} - {self.class_type}"


class TrainAvailability(models.Model):
    train_class = models.ForeignKey(TrainClass, on_delete=models.CASCADE, related_name='availability')
    date = models.DateField()
    available_seats = models.IntegerField()

    class Meta:
        unique_together = ('train_class', 'date')

    def __str__(self):
        return f"{self.train_class} - {self.date} - {self.available_seats} seats"