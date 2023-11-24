from django.db import models

# Create your models here.
class Stream(models.Model):
    """ Stream objects table """

    def upload_music_file(self, filename):
        """ simple function to handle uploaded music files """
        return f"streams/{self.user.email}/{self.pk}/{filename}"

    def upload_thumb_file(self, filename):
        """ simple function to handle uploaded music thumb files """
        return f"streams/{self.user.email}/{self.pk}/thumbs/{filename}"

    title = models.CharField(max_length=150)
    music = models.FileField(upload_to=upload_music_file)
    user = models.ForeignKey(settings.AUTH_USER_MODEL,
                    on_delete=models.CASCADE, related_name="streamed_musics")
    description = models.TextField(max_length=512, null=True, blank=True)
    image = models.ImageField(upload_to=upload_thumb_file, null=True, blank=True)
    date_created = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title
