#!/bin/bash
set -eu

if [ ! -f .vault_password_file.txt ]; then
  pwgen -ys 2048 1 > .vault_password_file.txt
fi

cp .vault_password_file.txt /tmp
chmod 444 /tmp/.vault_password_file.txt

if [ -d /data/ssh_keys ]; then
  cp -a /data/ssh_keys/. /root/.ssh/
  find /root/.ssh/ -type f -exec chmod 400 {} \;
fi

export ANSIBLE_COLLECTIONS_PATHS="$PWD/galaxy/collections"
export ANSIBLE_ROLES_PATH="$PWD/galaxy/roles:$PWD/roles"
export ANSIBLE_HOST_KEY_CHECKING=false
export ANSIBLE_INVENTORY="./inventory.yml"
export ANSIBLE_PIPELINING=true
export ANSIBLE_VAULT_PASSWORD_FILE="/tmp/.vault_password_file.txt"

if [ ! -d galaxy ]; then
  ansible-galaxy install -r requirements.yml
fi

if [ "$DOCKER_TASK" = "check_update" ] ; then
  ansible-playbook playbooks/check_update.yml
fi

if [ "$DOCKER_TASK" = "configure" ] ; then
  ansible-playbook playbooks/run.yml --tags "configure"
fi

if [ "$DOCKER_TASK" = "deploy" ] ; then
  ansible-playbook playbooks/run.yml --tags "deploy"
fi

if [ "$DOCKER_TASK" = "lint" ] ; then
  yamllint -sc /ansible/yamllint.yml /ansible/

  ansible-lint -p -c .ansible-lint playbooks/check_update.yml playbooks/preseed.yml playbooks/run.yml playbooks/update.yml
  ansible-playbook --syntax-check /ansible/playbooks/check_update.yml
  ansible-playbook --syntax-check /ansible/playbooks/preseed.yml
  ansible-playbook --syntax-check /ansible/playbooks/run.yml
  ansible-playbook --syntax-check /ansible/playbooks/update.yml
fi

if [ "$DOCKER_TASK" = "ping" ] ; then
  ansible all -m ping
fi

if [ "$DOCKER_TASK" = "preseed" ] ; then
  ansible-playbook playbooks/preseed.yml
fi

if [ "$DOCKER_TASK" = "update" ] ; then
  if [ -z "$DOCKER_LIMIT" ]
  then
    ansible-playbook playbooks/update.yml
  else
    ansible-playbook playbooks/update.yml --limit "${DOCKER_LIMIT}"
  fi
fi

if [ "$DOCKER_TASK" = "vault" ] ; then
  read -p "Name of variable: " VAULT_NAME
  read -s -p "String to encrypt: " VAULT_STRING_TO_ENCRYPT

  printf "\n\nEncrypted variable :\n"
  ansible-vault encrypt_string "${VAULT_STRING_TO_ENCRYPT}" --name "${VAULT_NAME}"
fi
