#!/usr/bin/python3

import os
import sys

sys.path.insert(0, '/opt/IAS/lib/python3')
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(sys.argv[0])), '../lib/python3'))) # pylint: disable=line-too-long

# pylint: disable=wrong-import-position
# Put your imports here:
import ias.network.sample_app1

# pylint: enable=wrong-import-position
app = ias.network.sample_app1.sample_app1()
app.run()
