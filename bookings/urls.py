from django.urls import path
from .views import CreateOrderView, VerifyPaymentView, MyBookingsView

urlpatterns = [
    path("create-order/", CreateOrderView.as_view(), name="create-order"),
    path("verify-payment/", VerifyPaymentView.as_view(), name="verify-payment"),
    path("my/", MyBookingsView.as_view(), name="my-bookings"),
]