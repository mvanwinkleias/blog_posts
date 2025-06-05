#!/usr/bin/python3

import tarfile
import zipfile
import sys
import os
import shutil

from packaging.utils import canonicalize_name

class mv_pip_repo:

    def __init__(self):
        self.debug = True

    def print_debug_message(self, message):
        if (self.debug == True):
            print(message)

    def get_package_name_from_tar_gz_file(self, filename):

        self.print_debug_message("Reading .tar.gz file: " + filename)
        tar_gz = tarfile.open(filename, 'r:gz')

        # print(tar_gz.getnames())
        basename = os.path.basename(filename)
        stripped_filename = basename.rstrip('.tar.gz')
        # print("stripped file name: ")
        # print(stripped_filename)
        internal_name = os.path.join(stripped_filename,'PKG-INFO')
        self.print_debug_message("Extracting pkg info from: " + internal_name)
        member = tar_gz.getmember(internal_name)


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
        
    def get_package_name_from_whl_file(self, filename):
        self.print_debug_message("Reading whl file: " + filename)

        content_as_string = None
        with zipfile.ZipFile(filename,'r') as zip_file:
            wanted_path = None
            for name in zip_file.namelist():
                if (name.endswith('METADATA')):
                    wanted_path = name

            self.print_debug_message("Wanted metadata file: " + wanted_path)
            with zip_file.open(wanted_path, 'r') as metadata_file:
                content = metadata_file.read()

            content_as_string = content.decode()
        
        for line in content_as_string.splitlines():
            if line.startswith('Name: '):
                package_name = line.split('Name: ')[1]
                break

        # print("Package name: " + package_name)
        return package_name

    def get_repo_subdir(self, repo_dir, canonical_name):
        return os.path.join(repo_dir, canonical_name)

    def get_canonical_package_name_from_file(self, filename):
        package_name = None

        if ( filename.endswith('tar.gz') ):
            package_name = self.get_package_name_from_tar_gz_file(filename)
        elif ( filename.endswith('.whl') ):
            package_name = self.get_package_name_from_whl_file(filename)

        return canonicalize_name(package_name)
        
    def add_pip_file_to_repo(self, filename, dest_repo):
        self.print_debug_message("Filename: " + filename)

        canonical_name = self.get_canonical_package_name_from_file(filename)

        self.print_debug_message("Canonical name: " + canonical_name)

        repo_subdir = self.get_repo_subdir(dest_repo, canonical_name)

        os.makedirs(repo_subdir, exist_ok=True)

        shutil.copy(filename, repo_subdir)        

