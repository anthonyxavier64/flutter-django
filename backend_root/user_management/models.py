from django.db import models
import uuid

# Create your models here.
class User(models.Model):
    email = models.CharField(max_length=120, unique=True)
    password = models.CharField(max_length=120)
    profilePicId = models.UUIDField(null=True)

    def __str__(self):
        return self.email
