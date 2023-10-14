```
project_layout/
├── artifacts
│   └── project-layout
├── systems
│   ├── package_shell
│   └── full_project
├── doc
├── eph
│   ├── build
│   ├── test
│   │   ├── log
│   │   └── output
│   └── var
│       ├── build_root
│       │   └── opt
│       │       └── IAS
│       │           └── var
│       │               └── lib
│       ├── input
│       ├── log
│       ├── output
│       └── tmp
├── examples
├── src
│   ├── bin
│   │   └── example_program.sh
│   ├── cgi-bin
│   ├── lib
│   └── web
└── tests
    ├── bin
    ├── data
    ├── lib
    └── t


```

### Basic Program Ephemeral Directories

* ix_get_dir_eph_var_input - Files expected to be processed
* ix_get_dir_eph_var_output - Output files
* ix_get_dir_eph_var_tmp - Temporary files (when /tmp isn't appropriate)
* ix_get_dir_eph_var_log - Log files

### User Directories


#### Home Directory

This is for getting the home directory.  You might think it could just be $HOME,
but it's not.

Should it be the home directory of:?

* Process owner - IAS_Infra_Home_Style="process"
* File owner - IAS_Infra_Home_Style="owner"
* An arbitrary string - IAS_Infra_Home_Style = "string" ; IAS_Infra_Home_String = "/some/random/dir"
* A different user - IAS_Infra_Home_Style = "other_user" ; IAS_Infra_Home_User = "bob"

* ix_get_dir_home

### 4th Wall Directories

#### Project Directories

* ix_get_dir_project - root of "project" directory; typically determined by $BIN_DIR/../../
	* ix_get_dir_project_src
	* ix_get_dir_project_tests
	...
	
* ix_get_dir_bin_base - typically src/bin .  bin_dir will always refer to the directory containing
the current script that's being executed.
	* ix_bin_whence - specifies which "bin" directory all of this is supposed to be calculated from
		* real - the actual path to the script
		* symbolic - if the script was run through a symbolic link, then the directory containing the symbolic link is used

 

#### Build System

These directories can be used to "interact" with the build system.

An example would be to install some output files, such as a json extract
or maybe an sqlite database.

* ix_get_dir_eph_var_log_build_root
* ix_get_dir_eph_var_build_root_var_lib

