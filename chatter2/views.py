from pyramid.view import view_config
from pyramid.security import authenticated_userid, remember, forget
from pyramid.httpexceptions import HTTPFound

from socketio.namespace import BaseNamespace
from socketio import socketio_manage
from socketio.mixins import BroadcastMixin

from pymongo import MongoClient
import pymongo
from bson.objectid import ObjectId

client = MongoClient()
db = client.chat
chat_history = db.chat_history
user = db.user

from datetime import timedelta, datetime as dt
import pytz

@view_config(route_name='index',
             renderer='templates/index.mako',
             permission='view')
def index(request):
    if authenticated_userid(request):
        login_flag = 1
        user_id = authenticated_userid(request)
        _id = ObjectId(user_id)
        user_data = user.find_one({"_id":_id})
        user_data['_id'] = str(user_data['_id'])
    else:
        login_flag = 0
        user_data = {}
        ##headers = remember(request, 10)
        ##return HTTPFound(location='/login', headers=headers)
    if request.POST.get('s_username'):
        username = request.POST.get('s_username')
        password = request.POST.get('s_password')

        user_data = {'username':username, 'password':password,\
                'nickname':username, 'textcolor':'#000000'}
        user_id = user.insert(user_data)
        headers = remember(request, str(user_id))
        return HTTPFound(location=request.url, headers=headers)
    if request.POST.get('l_username'):
        username = request.POST.get('l_username')
        password = request.POST.get('l_password')

        user_data = user.find_one({"username":username})
        if user_data and user_data['password'] == password:
            user_id = user_data['_id']
            headers = remember(request, str(user_id))
            return HTTPFound(location=request.url, headers=headers)
        user_data['_id'] = str(user_data['_id'])

    if request.POST.get('e_nickname'):
        user_id = request.POST.get('e_user_id')
        _id = ObjectId(user_id)
        nickname = request.POST.get('e_nickname')
        textcolor = request.POST.get('e_textcolor')
        user.update({"_id":_id},{"$set":{"nickname":nickname,"textcolor":textcolor}})

        user_data = user.find_one({"_id":_id})
        user_data['_id'] = str(user_data['_id'])

    return {'login_flag': login_flag,
            'user_data': user_data}

@view_config(route_name='logout')
def logout(request):
    headers = forget(request)
    return HTTPFound(location = request.route_url('index'),
                     headers = headers)

@view_config(route_name='login',
             renderer='templates/login.mako',
             permission='view')
def login(request):
    print authenticated_userid(request)
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
    def on_chat(self, msg, user_id):
        _id = ObjectId(user_id)
        user_data = user.find_one({"_id":_id})
        nickname = user_data['nickname']
        textcolor = user_data['textcolor']

        raw_time = dt.now(pytz.timezone("Asia/Shanghai"))
        time = dt.strftime(raw_time,'%H:%M:%S')

        chat_data = {'time':raw_time, 'msg':msg, 'user_id':user_id}
        chat_data_id = chat_history.insert(chat_data)

        self.broadcast_event('chat', time, msg, nickname, textcolor)

    def recv_connect(self):
        chat_result = list(chat_history.find().sort([("time", pymongo.DESCENDING)]).limit(10))
        chat_list = []
        for row in chat_result:
            time = row['time'] + timedelta(hours=8)
            user_id = row.get('user_id')
            if user_id:
                _id = ObjectId(user_id)
                user_data = user.find_one({"_id":_id})
                nickname = user_data['nickname'] 
                textcolor = user_data['textcolor'] 
            else:
                username = 'not known'
                textcolor = '#000000'
            chat_list = [{'time':dt.strftime(time,'%H:%M:%S'), 'msg':row['msg'], 'nickname':nickname, 'textcolor':textcolor}]+chat_list
        ##self.broadcast_event('user_connect',chat_list)
        self.emit('user_connect',chat_list)

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

