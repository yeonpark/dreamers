from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework import status, serializers

from django.contrib.auth.hashers import make_password, check_password
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError

from base.serializers import (
    UserSerializerWithToken,
    UserSerializer,
    NotificationSerializer,
    UserProfileSerializer,
    UserProfileImageSerializer,
)
from base.models import UserProfile, Notification


class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    def validate(self, attrs):
        data = super().validate(attrs)
        serializer = UserSerializerWithToken(self.user).data
        for k, v in serializer.items():
            data[k] = v
        return data


class MyTokenObtainPairView(TokenObtainPairView):
    serializer_class = MyTokenObtainPairSerializer


@api_view(["POST"])
def registerUser(request):
    data = request.data
    try:
        user = User.objects.create(
            first_name=data["username"],
            username=data["username"],
            email=data["email"],
            password=make_password(data["password"]),
        )

        serializer = UserSerializerWithToken(user, many=False)
        profile = UserProfile.objects.create(
            user=user,
            donations_made=0,
            story_made=0,
            total_donation_size=0,
            introduction="",
        )
        profile.save()
        return Response(serializer.data)
    except:
        message = {"detail": "User with this email already exists"}
        return Response(message, status=status.HTTP_400_BAD_REQUEST)


@api_view(["PUT"])
@permission_classes([IsAuthenticated])
def changePassword(request):
    user = request.user
    data = request.data
    try:
        if not check_password(data["currentPassword"], user.password):
            raise ValidationError("Current Password is wrong")
        if data["currentPassword"] == data["newPassword"]:
            raise ValidationError("New password cannot be same as current password")
        user.password = make_password(data["newPassword"])
        user.save()
        return Response(True)
    except ValidationError as e:
        raise serializers.ValidationError(e.message)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getUser(request):
    user = request.user
    serializer = UserSerializer(user)
    return Response(serializer.data)


@api_view(["GET"])
@permission_classes([IsAdminUser])
def getUsers(request):
    users = User.objects.all()
    serializer = UserSerializer(users, many=True)
    return Response(serializer.data)


@api_view(["PUT"])
@permission_classes([IsAuthenticated])
def changeEmail(request):
    user = request.user
    data = request.data
    try:
        if user.email == data["newEmail"]:
            raise ValidationError("New email cannot be same as current email.")
        user.email = data["newEmail"]
        user.save()
        return Response(True)
    except ValidationError as e:
        raise serializers.ValidationError(e.message)


@api_view(["PUT"])
@permission_classes([IsAuthenticated])  # verify with token
def changeUsername(request):
    user = request.user
    data = request.data
    try:
        if user.username == data["newUsername"]:
            raise ValidationError("New username cannot be same as current username.")
        user.name = data["newUsername"]
        user.save()
        return Response(True)
    except ValidationError as e:
        raise serializers.ValidationError(e.message)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getNotifications(request):
    if not request.user:
        raise ValidationError("You must sign up to wishlist.")
    user = request.user
    profile = UserProfile.objects.get(user=user)
    notifications = profile.notification_profile.get(read=False)
    serializer = NotificationSerializer(notifications, many=True)
    return Response(serializer.data)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def getUserProfile(request):
    user = request.user
    if UserProfile.objects.filter(user=user).exists():
        profile = UserProfile.objects.get(user=user)
    else:
        profile = UserProfile.objects.create(
            user=user,
            donations_made=0,
            story_made=0,
            total_donation_size=0,
            introduction="",
        )
    serializer = UserProfileSerializer(profile, many=False)
    return Response(serializer.data)


# name, email, nickname, profile_image, introduction


@api_view(["PUT"])
@permission_classes([IsAuthenticated])
def uploadProfileImage(request):
    user = request.user
    if UserProfile.objects.filter(user=user).exists():
        profile = UserProfile.objects.get(user=user)
        profile.profile_image = request.FILES.get("profile_image")
        profile.save()
        serializer = UserProfileImageSerializer(profile)
        return Response(serializer.data)


@api_view(["PUT"])
@permission_classes([IsAuthenticated])
def updateUserProfile(request):
    user = request.user
    data = request.data

    if UserProfile.objects.filter(user=user).exists():
        profile = UserProfile.objects.get(user=user)
        profile.introduction = data["introduction"]
        profile.save()
    else:
        profile = UserProfile.objects.create(
            user=user,
            donations_made=0,
            story_made=0,
            total_donation_size=0,
            introduction="",
        )

    serializer = UserProfileSerializer(profile, many=False)

    return Response(serializer.data)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getNotifications(request):
    user = request.user
    profile = UserProfile.objects.prefetch_related("notification_user").get(user=user)
    serializer = NotificationSerializer(profile.notification_user, many=True)
    return Response(serializer.data)


@api_view(["PUT"])
@permission_classes([IsAuthenticated])
def readNotification(request, pk):
    notification = Notification.objects.get(pk=pk)
    notification.read = True
    notificatino.save()
    return Response(True)
