from django.urls import path
from .views import TrainCreateUpdateView, TrainSearchView

urlpatterns = [
    path('', TrainCreateUpdateView.as_view()),
    path('search/', TrainSearchView.as_view()),
]
