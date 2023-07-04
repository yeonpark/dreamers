import uuid
from django.db import models
from django.contrib.auth.models import User
from imagekit.models import ImageSpecField
from imagekit.processors import ResizeToFill


class Social(models.Model):
    _id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)


class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    profile_image = models.ImageField(
        upload_to="profile", default="profile_placeholder.png"
    )
    donations_made = models.IntegerField(blank=True, null=True, default=0)
    story_made = models.IntegerField(blank=True, null=True, default=0)
    total_donation_size = models.IntegerField(null=True, blank=True, default=0)
    createdAt = models.DateTimeField(auto_now_add=True)
    introduction = models.TextField(blank=True, null=True)


class Donation(models.Model):
    _id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)
    doner = models.ForeignKey(
        UserProfile,
        on_delete=models.CASCADE,
        null=False,
        editable=False,
        related_name="donation_user",
    )
    created_at = models.DateTimeField(auto_now_add=True)
    donation_size = models.DecimalField(max_digits=7, decimal_places=2, default=0)
    fund_transfered = models.BooleanField(default=False)


class StoryTag(models.Model):
    keyword = models.CharField(primary_key=True, max_length=30)


class StoryFinance(models.Model):
    _id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)
    total_fund_request_size = models.DecimalField(
        max_digits=7, decimal_places=2, default=0
    )
    current_donated_size = models.DecimalField(
        max_digits=7, decimal_places=2, default=0
    )
    donations = models.ManyToManyField(
        Donation, blank=True, related_name="storyfinance_donations"
    )


class Story(models.Model):
    _id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)
    user = models.ForeignKey(
        UserProfile,
        on_delete=models.CASCADE,
        null=False,
        editable=False,
        related_name="story_user",
    )
    tags = models.ManyToManyField(StoryTag, blank=True, related_name="story_tag")
    heading = models.CharField(max_length=50)
    sub_heading = models.CharField(max_length=50)
    country = models.CharField(max_length=30)
    summary = models.TextField()
    full_detail = models.TextField()
    is_verified = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    finance = models.OneToOneField(
        StoryFinance,
        blank=False,
        on_delete=models.CASCADE,
        related_name="story_finance",
    )

    def __str__(self):
        return self.heading

    class Meta:
        ordering = ["created_at"]


class StoryImage(models.Model):
    item = models.ForeignKey(Story, on_delete=models.CASCADE, related_name="item_image")
    image = models.ImageField(upload_to="item")
    thumbnail = models.BooleanField(default=False)

    def __str__(self):
        return self.item.heading


class Like(models.Model):
    _id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)
    user = models.ForeignKey(
        UserProfile, on_delete=models.CASCADE, related_name="like_user"
    )
    story = models.ForeignKey(
        Story, on_delete=models.CASCADE, related_name="like_story"
    )


class Notification(models.Model):
    user = models.ForeignKey(
        UserProfile, on_delete=models.CASCADE, related_name="notification_user"
    )
    title = models.CharField(max_length=20, blank=True)
    description = models.TextField(blank=True)
    read = models.BooleanField(default=False)
