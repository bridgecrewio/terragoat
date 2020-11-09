#!/usr/bin/env bash

apt-get update
apt-get -y install figlet jq make

# Generate system banner
figlet "${welcome_message}" > /etc/motd

# Setup DNS Search domains
echo 'search ${search_domains}' > '/etc/resolvconf/resolv.conf.d/base'
resolvconf -u

# Setup local vanity hostname
echo '${hostname}' | sed 's/\.$//' > /etc/hostname
hostname `cat /etc/hostname`

##
## Setup SSH Config
##
cat <<"__EOF__" > /home/${ssh_user}/.ssh/config
Host *
    StrictHostKeyChecking no
__EOF__
chmod 600 /home/${ssh_user}/.ssh/config
chown ${ssh_user}:${ssh_user} /home/${ssh_user}/.ssh/config

# Setup default `make` support
echo 'alias make="make -C /usr/local/include --no-print-directory"' >> /etc/skel/.bash_aliases
cp /etc/skel/.bash_aliases /root/.bash_aliases
cp /etc/skel/.bash_aliases /home/${ssh_user}/.bash_aliases

echo 'default:: help' > /usr/local/include/Makefile
echo '-include Makefile.*' >> /usr/local/include/Makefile

##
## Makefile help
##
cat <<"__EOF__" > /usr/local/include/Makefile.help

# Ensures that a variable is defined
define assert-set
  @[ -n "$($1)" ] || (echo "$(1) not defined in $(@)"; exit 1)
endef

default:: help

.PHONY : help
## This help screen
help:
	@printf "Available targets:\n\n"
	@awk '/^[a-zA-Z\-\_0-9%:\\]+:/ { \
			helpMessage = match(lastLine, /^## (.*)/); \
			if (helpMessage) { \
					helpCommand = $$$1; \
					helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
						gsub("\\\\", "", helpCommand); \
						gsub(":+$$$", "", helpCommand); \
					printf "  \x1b[32;01m%-35s\x1b[0m %s\n", helpCommand, helpMessage; \
			} \
	} \
	{ lastLine = $$$0 }' $(MAKEFILE_LIST) | sort -u
	@printf "\n"

__EOF__
chmod 644 /usr/local/include/Makefile.help

${user_data}