#!/usr/bin/python3

import os
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(sys.argv[0])), 'lib'))) # pylint: disable=line-too-long

import ias.network.smtpauthparse.parser

parser = ias.network.smtpauthparse.parser.some_class()

parser.say_hello()
