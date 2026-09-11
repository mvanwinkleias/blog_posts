import time
import requests
import urllib3
import json
import pprint

import warnings
"""
Icinga is a monitoring platform similar to Nagios.

It has a web API that is documented in the form of curl commands run in a shell.
* https://icinga.com/docs/icinga-2/latest/doc/12-icinga2-api/

It has predefined header overrides for when HTTP methods don't align well with
what is being attempted.

This library hopefully standardizes all interaction with the API so you don't
need to know the particulars of the REST HTTP API.

The API ends up implementing CRUD, but they don't say it.

Method | Action | API Method name
-------+--------+--------------------
PUT     Create   do_create(uri, data)
GET     Read     do_read(uri, data)
POST    Update   do_update(uri, data)
DELETE  Delete   do_delete(uri, data)

Where 'data' is a Python dictionary (which the library will
automatically convert to the JSON that the REST API uses).

Configuration:

Pass a dictionary with the following into the constructor:

    {
        "host": "icinga.example.com",
        "port" : 5665,
        # if the remote server isn't using secure certs
        # this turns off verify and urllib warnings for this session only
        "verify_secure": false, 
        # https://requests.readthedocs.io/en/latest/api/#requests.Session.cert
        # (untested)
        "cert" : <path to cert> 
        "user": "icinga_api_user",
        "password": "icinga_api_password",
        "api_url": "/v1"
    }

Example usage:
You can specify an API path or an array that corresponds to one.
    i.e. ['objects','hosts'] is the same thing as '/objects/hosts':

    icinga_api.do_read(
        ['objects','hosts'], # (or '/objects/hosts')
        {
            'filter' : 'match("*auto*", host.name)',
            'attrs' : ['state','notes'],
        },
    ))

"""

class marty_icinga_api_crud_https:
    def __init__(self, config):

        self.config = config


        self.requests_session = requests.Session()

        if 'cert' in self.config:
            self.requests_session.cert = self.config['cert']

        if (
            'user' in self.config
            and 'password' in self.config
        ):
            self.requests_session.auth = (self.config['user'], self.config['password'])


        # pprint.pprint(self.requests_session.__dict__)
        if 'verify_secure' in self.config:
            if self.config['verify_secure'] == False:
                self.requests_session.verify = False

        self.last_api_call = {}

        self.default_accept_header = 'application/json'

    def print_debug(self, *args, **kwargs):
        if 'debug' in self.config:
            if self.config['debug']:
                print(*args, **kwargs)

    def requests_raise_for_status(self, *args, **kwargs):

        # pprint.pprint(self.config)
        request = requests.Request(
            *args,
            **kwargs,
        )


        if False:
            print("===Request raise for status===")
            print("")
            print("args:")
            pprint.pprint(args)
            print("---")
            print("kwargs:")
            pprint.pprint(kwargs)
            print("---")
            return

        prepared_request = self.requests_session.prepare_request(request)

        self.last_api_call['issue_time'] = time.time()

        # print("HEEEEEEEEERE")
        # pprint.pprint(self.requests_session.__dict__)

        if self.requests_session.verify == False:
            with warnings.catch_warnings():
                warnings.simplefilter('ignore', urllib3.exceptions.InsecureRequestWarning)
                response = self.requests_session.send(prepared_request)
        else:
            response = self.requests_session.send(prepared_request)

        self.last_api_call['response'] = response

        self.print_debug(response.text)
        self.print_debug(response.status_code)
        
        try:
            response.raise_for_status()
        except requests.HTTPError as http_err:
            self.print_debug(f"HTTP error: {http_err}")
            raise
        return json.loads(response.text)

    def make_rest_api_call(self, *args, headers = None, **kwargs):

        if headers is None:
            headers = {}

        if 'Accept' not in headers:
            headers['Accept'] = self.default_accept_header

        # Just convert everything not a PUT/POST to a POST and set the appropriate
        # override.
        # https://icinga.com/docs/icinga-2/latest/doc/12-icinga2-api/#request-method-override
        # There's no good reason to not do this (unless it doesn't work XD )

        if kwargs['method'] == 'GET':
            headers['X-HTTP-Method-Override'] = 'GET'
            kwargs['method'] = 'POST'

        if kwargs['method'] == 'DELETE':
            headers['X-HTTP-Method-Override'] = 'DELETE'
            kwargs['method'] = 'POST'

        return self.requests_raise_for_status(
            *args,
            headers = headers,
            **kwargs,
        )

    def construct_url(self, uri):

        path = uri
        if isinstance(uri, list):
            path = '/' + '/'.join(uri)
            
        url = (
            f"https://{self.config['host']}:{self.config['port']}"
            f"{self.config['api_url']}"
            f"{path}"
        )
        return url

    def do_create(self, uri, data = None):
        url = self.construct_url(uri)
        
        return self.make_rest_api_call(
            method = 'PUT',
            data = json.dumps(data),
            url = url,
        )

    def do_read(self, uri, data = None):
        url = self.construct_url(uri)

        return self.make_rest_api_call(
            method = 'GET',
            data = json.dumps(data),
            url = url,
        )

    def do_update(self, uri, data = None):
        url = self.construct_url(uri)

        return self.make_rest_api_call(
            method = 'POST',
            data = json.dumps(data),
            url = url,
        )

    def do_delete(self, uri, data = None):
        url = self.construct_url(uri)

        return self.make_rest_api_call(
            method = 'DELETE',
            data = json.dumps(data),
            url = url
        )

