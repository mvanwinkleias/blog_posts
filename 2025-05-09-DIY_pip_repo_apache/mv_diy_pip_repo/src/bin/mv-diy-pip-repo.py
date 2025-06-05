#!/usr/bin/python3

import sys
import os

sys.path.append('/opt/IAS/lib/python3')
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(sys.argv[0])), '../lib/python3'))) # pylint: disable=line-too-long

import ias.network.mv_pip_repo

from packaging.utils import canonicalize_name


if __name__ == "__main__":
    pip_repo = ias.network.mv_pip_repo.mv_pip_repo()

    if (len(sys.argv) < 3):
        print("Usage: file1 [file2 ...] dest_repo",
                file=sys.stderr
        )
        sys.exit(1)

    new_args = sys.argv[1:]
    dest_repo = new_args.pop()

    if (not os.path.isdir(dest_repo) ):
        print("Error: last argument is destination repo directory. "
            + dest_repo
            + " is not a directory.",
            file=sys.stderr,
        )

    for filename in new_args:
        if os.path.isfile(filename):
            pip_repo.add_pip_file_to_repo(filename, dest_repo)
        else:
            print("Error: " + filename + " is not a file...", file=sys.stderr)


