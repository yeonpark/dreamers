from django.db.models.signals import pre_save, post_save
from django.dispatch import receiver
from base.models import Like, Notification, StoryFinance, Donation
import decimal


@receiver(post_save, sender=Like)
def likeStory(sender, instance, created, **kwards):
    like = instance
    if created:
        Notification.objects.create(
            user=like.user, title="new like", description="liked"
        )


@receiver(pre_save, sender=StoryFinance)
def fullyDonated(sender, instance, **kwards):
    storyfinance = instance

    if storyfinance.total_fund_request_size == storyfinance.current_donated_size:
        # execute payments.
        return


@receiver(post_save, sender=Donation)
def donationMade(sender, instance, created, **kwards):
    donation = instance
    if created:
        profile = donation.doner
        profile.total_donation_size += decimal.Decimal(donation.donation_size)
        profile.donations_made += 1
        profile.save()
