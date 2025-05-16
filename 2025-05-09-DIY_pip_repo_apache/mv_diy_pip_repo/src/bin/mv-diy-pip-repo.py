#!/usr/bin/python3

import tarfile
import sys
import os

from packaging.utils import canonicalize_name


def get_package_name_from_tar_gz_file(filename):
    tar_gz = tarfile.open(filename, 'r:gz')

    # print(tar_gz.getnames())
    basename = os.path.basename(filename)
    stripped_filename = basename.rstrip('.tar.gz')
    # print("stripped file name: ")
    # print(stripped_filename)

    member = tar_gz.getmember(stripped_filename+'/PKG-INFO')
    file_object = tar_gz.extractfile(member)
    content = file_object.read()

    content_as_string = content.decode()

    # print(content_as_string)

    file_object.close()

    for line in content_as_string.splitlines():
        if line.startswith('Name: '):
            package_name = line.split('Name: ')[1]
            break

    # print("Package name: " + package_name)
    return package_name
    

canonical_name = canonicalize_name(
    get_package_name_from_tar_gz_file(
        sys.argv[1],
    )
)

print("Canonical name: " + canonical_name)
