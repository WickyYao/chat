from socketio.namespace import BaseNamespace
from socketio import socketio_manage
from socketio.mixins import BroadcastMixin

from pymongo import MongoClient
import pymongo
client = MongoClient()
db = client.chat
chat_history = db.chat_history

from datetime import timedelta, datetime as dt
import pytz


def index(request):
    """ Base view to load our template """
    return {}


class NamedUsersRoomsMixin(BroadcastMixin):
    def __init__(self, *args, **kwargs):
        super(NamedUsersRoomsMixin, self).__init__(*args, **kwargs)
        if 'rooms' not in self.session:
            self.session['rooms'] = set()  # a set of simple strings
            self.session['nickname'] = 'guest123'

    def join(self, room):
        """Lets a user join a room on a specific Namespace."""
        self.socket.rooms.add(self._get_room_name(room))

    def leave(self, room):
        """Lets a user leave a room on a specific Namespace."""
        self.socket.rooms.remove(self._get_room_name(room))

    def _get_room_name(self, room):
        return self.ns_name + '_' + room

    def emit_to_room(self, event, args, room):
        """This is sent to all in the room (in this particular Namespace)"""
        pkt = dict(type="event",
                   name=event,
                   args=args,
                   endpoint=self.ns_name)
        room_name = self._get_room_name(room)
        for sessid, socket in self.socket.server.sockets.iteritems():
            if not hasattr(socket, 'rooms'):
                continue
            if room_name in socket.rooms:
                socket.send_packet(pkt)


class ChatNamespace(BaseNamespace, NamedUsersRoomsMixin):
    def on_chat(self, msg):
        raw_time = dt.now(pytz.timezone("Asia/Shanghai"))
        time = dt.strftime(raw_time,'%H:%M:%S')

        chat_data = {'time':raw_time, 'msg':msg}
        chat_data_id = chat_history.insert(chat_data)

        self.broadcast_event('chat', time, msg)

    def recv_connect(self):
        chat_result = list(chat_history.find().sort([("time", pymongo.DESCENDING)]).limit(10))
        chat_list = []
        for row in chat_result:
            time = row['time'] + timedelta(hours=8)
            chat_list = [{'time':dt.strftime(time,'%H:%M:%S'), 'msg':row['msg']}]+chat_list
        self.broadcast_event('user_connect',chat_list)

    def recv_disconnect(self):
        self.broadcast_event('user_disconnect')
        self.disconnect(silent=True)

    def on_join(self, channel):
        self.join(channel)

    def on_writing(self, val):
        self.broadcast_event('writing', val)



from pyramid.response import Response
def socketio_service(request):
    socketio_manage(request.environ,
                    {'/chat': ChatNamespace},
                    request=request)

    return Response('')

