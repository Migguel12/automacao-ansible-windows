Automação de Atualização de Senhas com Ansible e Docker

Este projeto automatiza a atualização de senhas em computadores de uma rede corporativa, garantindo escalabilidade e eficiência para ambientes complexos, como escolas com várias unidades.

Descrição do Projeto
A principal funcionalidade deste projeto é realizar a atualização de senhas em computadores Windows, superando a limitação do Windows como nó de controle do Ansible.

Para isso, o projeto utiliza:

- Docker: Para criar um ambiente controlado onde o Ansible possa ser executado.
- Python: Para realizar o scanner da rede, identificando quais computadores estão disponíveis para atualização.
- Ansible: Para executar os playbooks que criam um usuário administrativo e trocam a senha dos computadores identificados.


Descrição do Projeto
A principal funcionalidade deste projeto é realizar a atualização de senhas em computadores Windows, superando a limitação do Windows como nó de controle do Ansible.

Para isso, o projeto utiliza:

- Docker: Para criar um ambiente controlado onde o Ansible possa ser executado.
- Python: Para realizar o scanner da rede, identificando quais computadores estão disponíveis para atualização.
- Ansible: Para executar os playbooks que criam um usuário administrativo e trocam a senha dos computadores identificados.


Por que Docker Compose?
O uso do docker-compose facilita a escalabilidade e a execução do projeto em diferentes unidades. Ele:

- Permite configurar dependências e serviços de forma simples e organizada.
- Automiza o build e a execução do container com um único comando, simplificando o processo para o TI.


Como Usar
Pré-requisitos
- Ter o Docker Desktop instalado na máquina local.

Preparação
Baixe ou clone este repositório em sua máquina local.

Construção do Container
No terminal, navegue até a pasta do projeto e execute:
docker-compose build

Execução do Projeto
Ainda no terminal, execute:
docker-compose up

O projeto iniciará automaticamente o scanner de rede, criará os inventários e executará os playbooks necessários.

Acompanhamento
O processo será exibido no terminal. Aguarde até que o projeto seja finalizado.
