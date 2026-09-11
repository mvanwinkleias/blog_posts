#!/usr/bin/python3

import os
import sys

sys.path.insert(0, '/opt/IAS/lib/python3')
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(sys.argv[0])), '../lib/python3'))) # pylint: disable=line-too-long

import argparse
import json
import pprint

# import ias.network.marty_icinga_api_crud_https
import ias.network.icinga.marty_icinga_rest_api_client

class entry_point:
    def run(self):

        self.setup()

        if self.args.dump_self:
            pprint.pprint(self.__dict__)
            sys.exit(0)

        # hosts = self.icinga_api.objects.hosts.get(attrs=["name"])

        # pprint.pprint(hosts)

        self.run_commands()

    def run_commands(self):
        for command in self.commands:
            method = getattr(self.icinga_api, command['method'])
            result = method(*command['options'])
            print(json.dumps(result.data))

    def setup(self):
        self.parse_args()
        self.configure()

        # self.icinga_api = ias.network.marty_icinga_api_crud_https.marty_icinga_api_crud_https(
        #     self.config['icinga_api']
        # )

        self.icinga_api = ias.network.icinga.marty_icinga_rest_api_client.marty_icinga_rest_api_client(
            self.config['icinga_api']
        )

        self.commands = []
        self.load_commands()

    def load_commands(self):
        for json_file in self.args.run_json_file:
            commands = json.load(open(json_file))
            self.commands.append(*commands)

    def parse_args(self):
        arg_parser = argparse.ArgumentParser(
            description = "Entry point",
        )

        arg_parser.add_argument(
            '--dump-self',
            action = "store_true",
            help = "Dump self and exit",
        )

        arg_parser.add_argument(
            '--icinga-api-config-file',
            type = os.path.expanduser,
            default = "~/.config/IAS/icinga-api/config.json",
        )

        arg_parser.add_argument(
            '--run-json-file',
            action = 'append',
            help = "json file to run.",
        )

        self.args = arg_parser.parse_args()

    def configure(self):
        self.config = json.load(open(self.args.icinga_api_config_file))

if __name__ == "__main__":
    entry_point = entry_point()
    entry_point.run()
