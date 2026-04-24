#!/usr/bin/make -f

.NOTPARALLEL:

.PHONY: do_nothing
do_nothing:
	@:

.PHONY: signal_hello
signal_hello:
	echo "Hello."
.PHONY: signal_goodbye
signal_goodbye:
	echo "Goodbye."

.PHONY: signal_apache_config_has_changed
signal_apache_config_has_changed: handler_apache_reload_safe

.PHONY: handler_apache_reload_safe
handler_apache_reload_safe: apachectl_safe_graceful

.PHONY: apachectl_configtest
apache_test_config:
	apachectl configtest

.PHONY: apachectl_safe_graceful
apachectl_safe_graceful: apachectl_configtest
	apachectl graceful

.PHONY: apachectl_safe_restart
apachectl_safe_restart: apachectl_configtest
	apachectl restart
