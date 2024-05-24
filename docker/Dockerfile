# Use a imagem oficial do Python como base
FROM python:latest

#Instalar pacotes de sistema necessários
RUN apt-get update && \
    apt-get install -y \
    nmap \
    telnet && \
    rm -rf /var/lib/apt/lists/*

#Instalar ansible e pywinrm
RUN pip install "pywinrm>=0.3.0" \
    ansible

#Define o diretório de trabalho
WORKDIR /ansible

# Comando padrão a ser executado quando o contêiner for iniciado
CMD ["ansible-playbook", "ping.yaml"]
