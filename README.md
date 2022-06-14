# Introduction

This repo contains the code used to deploy and managing my various VM on VMware ESXi. Ansible is the main way I deploy things.

# Usage

## Deploy instructions

`make check_update`

`make configure` - Sets up and secures the hosts

`make deploy`

`make preseed` - Generates Debian iso with preseed file

`make update` - Runs apt update and apt upgrade on the hosts

`make update_vm_applications` - Runs apt update and apt upgrade on vm-esxi-applications

`make update_vm_network` - Runs apt update and apt upgrade on vm-esxi-network

## Setup instructions

`make build` - Builds ansible_infrastructure image

`make lint`

`make ping`

`make vault` - Encrypts var with [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

# Thanks

- https://github.com/ironicbadger/infra
- https://github.com/RealOrangeOne/infrastructure
- https://github.com/notthebee/infra
- https://github.com/FuzzyMistborn/infra
