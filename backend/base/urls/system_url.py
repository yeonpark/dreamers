from django.urls import path
from base.views import system_view as views

urlpatterns = [
  path('is-server-working/', views.isServerOn, name='is_working'),
]