# Use a imagem oficial do Python como base
FROM python:latest

# Instalar pacotes de sistema necessários
RUN apt-get update && \
    apt-get install -y \
    nmap \
    telnet && \
    rm -rf /var/lib/apt/lists/*

# Instalar ansible e pywinrm
RUN pip install "pywinrm>=0.3.0" \
    ansible \
    python-nmap

# Define o diretório de trabalho
WORKDIR /ansible

# Copiar o script Python, playbooks e script de bash para dentro do contêiner
COPY script.py /ansible/script.py
COPY run_playbooks.sh /ansible/run_playbooks.sh
COPY ping.yaml /ansible/ping.yaml
COPY criar_usuario.yml /ansible/criar_usuario.yml
COPY troca_senha.yml /ansible/troca_senha.yml
COPY hosts /ansible/hosts
COPY host_criar_usuario /ansible/host_criar_usuario

# Dar permissão de execução ao script de bash
RUN chmod +x /ansible/run_playbooks.sh

# Comando padrão a ser executado quando o contêiner for iniciado
CMD ["/ansible/run_playbooks.sh"]
