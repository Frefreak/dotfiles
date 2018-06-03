#!/usr/bin/env sh

HOSTNAME=$(hostname)
PUBSSH=$(cat ~/.ssh/id_rsa.pub)

TF_VAR_hostname="$HOSTNAME" TF_VAR_pubssh="$PUBSSH" terraform apply
