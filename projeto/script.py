import nmap
import csv
from variaveis_destinos import GRA

destinos = GRA
portas = ['5985']          

nm = nmap.PortScanner()

# Abrir os arquivos para escrita
with open('/ansible/scan_resultados.csv', mode='w', newline='') as arquivo_csv, \
     open('/ansible/sem_comunicacao.csv', mode='w', newline='') as arquivo_sem_comunicacao_csv, \
     open('/ansible/hosts_nao_encontrados.csv', mode='w', newline='') as arquivo_nao_encontrados:

    # Inicializar escritores CSV
    escritor_csv = csv.writer(arquivo_csv)
    escritor_csv.writerow(['IP', 'Estado do Host', 'Porta', 'Estado da Porta', 'Destino'])

    escritor_sem_comunicacao_csv = csv.writer(arquivo_sem_comunicacao_csv)
    escritor_sem_comunicacao_csv.writerow(['IP', 'Estado do Host', 'Porta', 'Estado da Porta', 'Destino'])

    escritor_nao_encontrados = csv.writer(arquivo_nao_encontrados)
    escritor_nao_encontrados.writerow(['Destino'])

    # Realizar a varredura dos destinos
    for destino in destinos:
        nm.scan(hosts=destino, ports=",".join(portas))

        if nm.all_hosts():
            for host in nm.all_hosts():
                host_ip = host
                estado_host = nm[host_ip].state()
                for porta in portas:
                    estado_porta = nm[host_ip]['tcp'][int(porta)]['state']
                    if estado_porta == 'open':
                        escritor_csv.writerow([host_ip, estado_host, porta, estado_porta, destino])
                    else:
                        escritor_sem_comunicacao_csv.writerow([host_ip, estado_host, porta, estado_porta, destino])
        else:
            escritor_nao_encontrados.writerow([destino])

# Ler os hosts que foram encontrados e registrados no arquivo scan_resultados.csv
novos_hosts = []
with open('/ansible/scan_resultados.csv', mode='r') as arquivo_csv:
    leitor_csv = csv.reader(arquivo_csv)
    next(leitor_csv)  # Pular o cabeçalho
    for linha in leitor_csv:
        host_ip, estado_host, porta, estado_porta, destino = linha
        novo_host = f"{destino} ansible_host={host_ip}\n"
        novos_hosts.append(novo_host)

# Função para atualizar o arquivo de inventário do Ansible
def atualizar_inventario(caminho_arquivo_inventario, novos_hosts):
    with open(caminho_arquivo_inventario, mode='r') as arquivo_hosts_ansible_r:
        linhas_inventario = arquivo_hosts_ansible_r.readlines()

    # Limpar a seção de hosts existentes e adicionar os novos
    indice_inicio_windows = linhas_inventario.index('[windows]\n') + 1
    indice_fim_windows = linhas_inventario.index('[windows:vars]\n')

    linhas_inventario = linhas_inventario[:indice_inicio_windows] + novos_hosts + linhas_inventario[indice_fim_windows:]

    # Escrever o conteúdo atualizado de volta ao arquivo de inventário do Ansible
    with open(caminho_arquivo_inventario, mode='w') as arquivo_hosts_ansible_w:
        arquivo_hosts_ansible_w.writelines(linhas_inventario)

# Atualizar o arquivo de inventário do Ansible (hosts)
atualizar_inventario('/ansible/hosts', novos_hosts)
atualizar_inventario('/ansible/host_criar_usuario', novos_hosts)

print('Os resultados foram exportados para scan_resultados.csv')
print('Os hosts sem comunicação foram exportados para sem_comunicacao.csv')
print('Os hosts não encontrados foram exportados para hosts_nao_encontrados.csv')
print('Os hosts encontrados foram adicionados aos arquivos de inventário do Ansible (hosts e host_criar_usuario)')
