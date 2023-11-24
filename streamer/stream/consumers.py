from channels.generic.websocket import AsyncWebsocketConsumer


class AsyncWebsocketStreamer(AsyncWebsocketConsumer):
    """ Consumer for streaming musics part by part """

    async def connect(self):
        self.user = self.scope['user']
        self.music_pk = self.scope['url_route']['pk']
        self.room_name = f"music_{self.music_pk}"
        await self.channel_layer.add_group(
            self.room_name,
            self.channel_name
        )
        await self.accept()

    async def disconnect(self, code):
        await self.close(code)

    async def send_chunk(self, stream_data: bytes):
        await self.send(chunks=json.dumps(stream_data['music_part']))
