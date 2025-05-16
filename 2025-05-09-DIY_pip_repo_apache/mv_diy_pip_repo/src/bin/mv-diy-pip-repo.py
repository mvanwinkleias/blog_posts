#!/usr/bin/python3

import tarfile
import sys
import os
import shutil

from packaging.utils import canonicalize_name


def get_package_name_from_tar_gz_file(filename):
    tar_gz = tarfile.open(filename, 'r:gz')

    # print(tar_gz.getnames())
    basename = os.path.basename(filename)
    stripped_filename = basename.rstrip('.tar.gz')
    # print("stripped file name: ")
    # print(stripped_filename)

    member = tar_gz.getmember(os.path.join(stripped_filename,'PKG-INFO'))
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
    
def get_repo_subdir(repo_dir, canonical_name):
    return os.path.join(repo_dir, canonical_name)

def add_pip_file_to_repo(filename, dest_repo):
    print("Filename: " + filename)
    canonical_name = canonicalize_name(
        get_package_name_from_tar_gz_file(
            filename,
        )
    )

    print("Canonical name: " + canonical_name)

    repo_subdir = get_repo_subdir(dest_repo, canonical_name)

    os.makedirs(repo_subdir, exist_ok=True)

    shutil.copy(filename, repo_subdir)        

# dest_directory=

if __name__ == "__main__":
    add_pip_file_to_repo(sys.argv[1], sys.argv[2])


