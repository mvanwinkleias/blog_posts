import pprint

import ias.network.icinga.marty_icinga_api_crud_https

"""
This library provides named methods which align with the Icinga HTTP REST API
documentation, and CRUD.

| Icinga Doc Name | What It Really Does (CRUD)
| get             | read
| post            | update
| put             | create
| delete          | delete

In my opinion, you should use CRUD.  The nomenclature completely
(and correctly) abstracts the fact that this is backed by HTTP.

The CRUD methods better describe what's actually happening anyway.

If one were to naively write a class abstracting the Icinga API
as documented, it would be leaky.
( https://en.wikipedia.org/wiki/Leaky_abstraction )

Both of these examples accomplish the same thing and are supported,
but the first is preferable:

        icinga_result = self.icinga_api.read(
            ['objects','hosts'],
            {
                'filter' : 'match("*auto*", host.name)',
                'attrs' : [
                    'display_name',
                    'check_command',
                    'state',
                    'notes'
                ],

            },
        )

or (the leaky way, more corresponding to the documentation):

        icinga_result = self.icinga_api.get(
            '/objects/hosts',
            {
                'filter' : 'match("*auto*", host.name)',
                'attrs' : [
                    'display_name',
                    'check_command',
                    'state',
                    'notes'
                ],

            },
        )

It wraps the REST API call with something that returns an api result object.

The result object has methods for checking the results of API calls for
(say) errors reported by Icinga:

* has_errors() - if any results were in the 400's or 500's returns True
    else returns False
* is_complete_success() - if all results were in the 200's returns True
    else returns False

Common Errors:
    400's response codes from the API can mean that you're trying to
reach an endpoint that doesn't exist.  I don't know how to get those
messages back into errors (yet...).

Motivation:

The API documentation is particularly bad, in that if you were to
write a module to abstract it as written it would be leaky.

You should (in my strong opinion) use a complete abstraction
and only use the CRUD functionality.
"""

class marty_icinga_rest_api_results:
    def __init__(self, config = None, data = None):
        if data is None:
            pass
            # Prolly wanna do something different here

        if config is None:
            config = {}

        self.config = config.copy()

        if 'raise_error' not in self.config:
            self.config['raise_error'] = False

        self.data = data

        errors = []
        for result in self.data['results']:
            if (
                'code' in result
                and result['code'] >= 400
                and result['code'] <= 600
            ):
                errors.append(result)
        self.errors = errors

        if self.config['raise_error']:
            self.raise_unless_completely_successful()
    def has_errors(self):
        if ( len(self.errors) > 0 ):
            return True
        return False

    def is_complete_success(self):
        num_not_success = 0
        for result in self.data['results']:
            if (
                'code' in result
                and
                (
                    result['code'] < 200
                    or result['code'] >= 300
                )
            ):
                return False
        return True

    def raise_unless_completely_successful(self):
        if not self.is_complete_success():
            raise MartyIcingaRestApiResultError(
                "Not all calls were successful: \n"
                + pprint.pformat(self.data),
                1,
            )
class MartyIcingaRestApiResultError(Exception):
    def __init__(self, message, error_code):
        super().__init__(message)
        self.error_code = error_code
    pass

class marty_icinga_rest_api_client:
    def __init__(self,config):
        self.config = config.copy()

        self.icinga_crud_api = ias.network.icinga.marty_icinga_api_crud_https.marty_icinga_api_crud_https(
            self.config,
        )

        self.debug = False
        if 'debug' in self.config:
            self.debug = self.config['debug'] 

    def print_debug(self, *args, **kwargs):
        if (self.debug):
            print(*args, file=sys.stderr, **kwargs)

    def read(self, *args, **kwargs):
        return marty_icinga_rest_api_results(
            self.config,
            self.icinga_crud_api.do_read(
                *args, **kwargs
        ))
    get = read

    def update(self, *args, **kwargs):
        return marty_icinga_rest_api_results(
            self.config,
            self.icinga_crud_api.do_update(
                *args, **kwargs
        ))
    post = update
    

    def create(self, *args, **kwargs):
        return marty_icinga_rest_api_results(
            self.config,
            self.icinga_crud_api.do_create(
                *args, **kwargs
        ))
    put = create

    def delete(self, *args, **kwargs):
        return marty_icinga_rest_api_results(
            self.config,
            self.icinga_crud_api.do_delete(
                *args, **kwargs
        ))
