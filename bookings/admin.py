from django.contrib import admin
from .models import Booking

@admin.register(Booking)
class BookingAdmin(admin.ModelAdmin):
    list_display = ['user', 'train', 'train_class', 'seats_booked', 'booked_at']