from wsgiref.util import FileWrapper

from rest_framework import generics, status, permissions
from rest_framework.response import Response

from channels.layers import get_channel_layer

from ..models import Stream
from ..serializers import StreamSerializer, CreateStreamSerializer


class MusicStreamerAPI(generics.GenericAPIView):
    """ An API for streaming given music """

    serializer_class = StreamSerializer
    permission_classes = (permission_classes.IsAuthenticated,)

    def get(self, request, pk: int):
        """ get music and stream it """
        
        channel_layer = get_channel_layer()

        try:
            music = Stream.objects.get(pk=pk)
            with open(music.music.url, 'rb') as file:
                for chunk in file.read(4096):
                    if not chunk:
                        break

                    channel_layer.group_send(
                        f'music_{music.pk}',
                        {
                            'type': 'send.chunk',
                            'music_part': chunk
                        }
                    )
            return Response(self.get_serializer(music).data)

        except Stream.DoesNotExist:
            return Response({'error': 'Music Not Found'},
                            status=status.HTTP_404_NOT_FOUND)



class CreateMusicStream(generics.CreateAPIView):
    """ An API for creating streamable musics """

    serializer_class = CreateMusicStream
    permission_classes = (permissions.IsAuthenticated,)
    model = Stream
