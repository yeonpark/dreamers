from django.urls import path
from django.contrib import admin
from base.views import user_view as views

urlpatterns = [
    path("login/", views.MyTokenObtainPairView.as_view(), name="token_obtain_pair"),
    path("register/", views.registerUser, name="register"),
    path("change-pw/", views.changePassword, name="changepw"),
    path("get-user/", views.getUser, name="getuser"),
    path("get-users/", views.getUsers, name="getusers"),
    path("change-email/", views.changeEmail, name="changeEmail"),
    path("change-username/", views.changeUsername, name="changeUsername"),
    path(
        "upload-profile-image/", views.uploadProfileImage, name="upload_profile_image"
    ),
    path("profile/", views.getUserProfile, name="user_profile"),
    path("profile/update/", views.updateUserProfile, name="users_profile_update"),
    path("get-notifications/", views.getNotifications, name="getNotifications"),
    path(
        "read-notification/<str:pk>/", views.readNotification, name="readNotifications"
    ),
]
