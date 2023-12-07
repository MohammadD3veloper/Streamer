from rest_framework import serializers

from .models import Stream


class StreamSerializer(serializers.ModelSerializer):
    """ Serializer for stream objects """

    class Meta:
        model = Stream
        fields = ["title", "user", "description", "image", "date_created"]


class CreateStreamSerializer(serializers.ModelSerializer):
    """ Serializer for Creating stream objects """

    class Meta:
        model = Stream
        fields = ["title", "music", "description", "image", "date_created"]
