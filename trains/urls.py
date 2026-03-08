from django.urls import path
from .views import TrainCreateUpdateView, TrainSearchView, TrainClassCreateView

urlpatterns = [
    path('', TrainCreateUpdateView.as_view(), name='train-create'),
    path('<int:train_id>/classes/', TrainClassCreateView.as_view(), name='train-class-create'),
    path('search/', TrainSearchView.as_view(), name='train-search'),
]