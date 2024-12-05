#!/bin/bash

# Executar o script Python
python /ansible/script.py
if [ $? -ne 0 ]; then
  echo "Erro ao executar script.py"
fi

# Executar o playbook criar_usuario.yml
ansible-playbook -i /ansible/host_criar_usuario /ansible/criar_usuario.yml
if [ $? -ne 0 ]; then
  echo "Erro ao executar criar_usuario.yml"
fi

# Executar o playbook troca_senha.yml
ansible-playbook -i /ansible/hosts /ansible/troca_senha.yml
if [ $? -ne 0 ]; then
  echo "Erro ao executar troca_senha.yml"
fi
