Binaries that are generated with this start with the name "check"
and the .gitignore has been configured to ignore all things that begin
with "check".

The source code for your checks should start with "test".

This hopefully allows you to create test code that will be picked up
automatically by git, and then cause the resulting binaries to
be ignored.
