from django.urls import path
from django.contrib import admin
from base.views import user_view as views

urlpatterns = [
  path('login/', views.MyTokenObtainPairView.as_view(), name='token_obtain_pair'),
  path('register/', views.registerUser, name='register'),
  path('changepw/', views.changePassword, name='changepw')
]
