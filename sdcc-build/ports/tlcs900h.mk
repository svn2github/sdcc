# Disable the tlcs900h port
SDCCCONFIGUREFLAGS += --disable-tlcs900h-port

HELPTARGETS += tlcs900h-help

tlcs900h-help:
	@echo tlcs900h support is currently disabled.

