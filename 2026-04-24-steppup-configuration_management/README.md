Let's say you have 2 local git repos that need to be pulled, and if there are
changes to either of them you need to execute a make target:

```
cat <( \
./git_pull_and_signal.sh \
	"signal_hello signal_goodbye" \
	"origin master --quiet" \
	local_dirs/dir1/ \
	local_dirs/dir2/ \
) \
| xargs ./apache_control.mk
```

