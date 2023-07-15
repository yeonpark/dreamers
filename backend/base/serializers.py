from rest_framework import serializers
from django.contrib.auth.models import User
from rest_framework_simplejwt.tokens import RefreshToken
from .models import *


# User
class UserSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField(read_only=True)
    _id = serializers.SerializerMethodField(read_only=True)
    is_admin = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = User
        fields = ("_id", "is_admin", "username", "email", "name")

    def get__id(self, obj):
        return obj.id

    def get_is_admin(self, obj):
        return obj.is_staff

    def get_name(self, obj):
        name = obj.first_name
        if name == "":
            name = obj.username
        return name


class UserSerializerWithToken(UserSerializer):
    token = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = User
        fields = ("_id", "is_admin", "username", "email", "name", "token")

    def get_token(self, obj):
        token = RefreshToken.for_user(obj)
        return str(token.access_token)


class UserProfileImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ("profile_image",)


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = "__all__"


# Story Tag
class StoryTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = StoryTag
        fields = "__all__"


# Notification
class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = "__all__"

# Notification
class LikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Like
        fields = (
            "user",
        )


# Story
class StoryImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = StoryImage
        fields = ("image", "thumbnail")


class StorySerializer(serializers.ModelSerializer):
    images = StoryImageSerializer(source="item_image", many=True)
    user = UserProfileSerializer(read_only=True)
    category = StoryTagSerializer(read_only=True, many=True, source="tags")
    likes = LikeSerializer(read_only=True, many=True, source="like_story")

    class Meta:
        model = Story
        fields = (
            "_id",
            "user",
            "created_at",
            "category",
            "heading",
            "sub_heading",
            "full_detail",
            "summary",
            "images",
            "country",
            "is_verified",
            "likes",
        )


class StoryBriefSerializer(serializers.ModelSerializer):
    story_thumbnail = StoryImageSerializer(source="item_image", many=True)
    title = serializers.ReadOnlyField(source="heading")
    createDate = serializers.ReadOnlyField(source="created_at")
    category = StoryTagSerializer(read_only=True, many=True)

    class Meta:
        model = Story
        fields = (
            "_id",
            "createDate",
            "title",
            "summary",
            "story_thumbnail",
            "category",
        )


class StoryFinanceSerializer(serializers.ModelSerializer):
    class Meta:
        model = StoryFinance
        fields = "__all__"


# Donation
class DonationSerializer(serializers.ModelSerializer):
    class Meta:
        model = StoryFinance
        fields = "__all__"

# Like
class WishlistSerializer(serializers.ModelSerializer):
    story = StorySerializer(read_only=True)
    class Meta:
        model = Like
        fields = (
            "story",
        )