#!/usr/bin/env python
from pyramid.config import Configurator
from chatter2.views import socketio_service
from chatter2.views import index

from pyramid.authentication import AuthTktAuthenticationPolicy
from pyramid.authorization import ACLAuthorizationPolicy
from .security import groupfinder


def simple_route(config, name, url, fn):
    """
    Function to simplify creating routes in pyramid
    Takes the pyramid configuration, name of the route, url, and view
    function.
    """
    config.add_route(name, url)
    config.add_view(fn, route_name=name,
            renderer="chatter2:templates/%s.mako" % name)


def main(global_config, **settings):
    authn_policy = AuthTktAuthenticationPolicy(
        'sosecret', callback=groupfinder, hashalg='sha512')
    authz_policy = ACLAuthorizationPolicy()

    config = Configurator(settings=settings,
                          root_factory='.security.RootFactory')

    config.set_authentication_policy(authn_policy)
    config.set_authorization_policy(authz_policy)

    config.include('pyramid_mako')

    ##simple_route(config, 'index', '/', index)
    config.add_route('index', '/')
    config.add_route('login', '/login')
    config.add_route('logout', '/logout')

    # The socketio view configuration
    simple_route(config, 'socket_io', 'socket.io/*remaining', socketio_service)

    config.add_static_view('static', 'static', cache_max_age=3600)

    config.scan()

    app = config.make_wsgi_app()

    return app
