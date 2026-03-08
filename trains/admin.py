from django.contrib import admin
from .models import Train, TrainClass

@admin.register(Train)
class TrainAdmin(admin.ModelAdmin):
    list_display = ['train_number', 'name', 'source', 'destination', 'departure_time', 'arrival_time']

@admin.register(TrainClass)
class TrainClassAdmin(admin.ModelAdmin):
    list_display = ['train', 'class_type', 'total_seats', 'available_seats', 'price']