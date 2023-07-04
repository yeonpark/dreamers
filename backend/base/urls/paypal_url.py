from django.urls import path
from django.contrib import admin
from base.views import paypal_view as views

urlpatterns = [
    # path('create/order/', views.CreateOrderView.as_view(), name='createOrder'),
    # path('capture/order/', views.CaptureOrderView.as_view(), name='captureOrder'),
    path('create-donation/<str:pk>/', views.createDonation, name="create-donations")
]
