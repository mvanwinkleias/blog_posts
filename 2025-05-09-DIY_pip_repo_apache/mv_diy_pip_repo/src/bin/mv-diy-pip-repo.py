#!/usr/bin/python3

import tarfile
import sys
import os
import shutil

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(sys.argv[0])), '../lib/python3'))) # pylint: disable=line-too-long
import ias.network.mv_pip_repo

from packaging.utils import canonicalize_name


if __name__ == "__main__":
    pip_repo = ias.network.mv_pip_repo.mv_pip_repo()

    pip_repo.add_pip_file_to_repo(sys.argv[1], sys.argv[2])


