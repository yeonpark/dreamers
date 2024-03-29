# Generated by Django 4.1.7 on 2023-07-15 01:32

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='like',
            name='created_at',
            field=models.DateTimeField(auto_now_add=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='notification',
            name='description',
            field=models.TextField(blank=True),
        ),
        migrations.AlterField(
            model_name='notification',
            name='title',
            field=models.CharField(blank=True, max_length=20),
        ),
    ]
