# Generated by Django 3.2.4 on 2021-06-08 21:07

from django.db import migrations, models
import uuid


class Migration(migrations.Migration):

    dependencies = [
        ('user_management', '0002_user_profilepicid'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='profilePicId',
            field=models.UUIDField(default=uuid.uuid4),
        ),
    ]
