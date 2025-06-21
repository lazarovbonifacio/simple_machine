# Simple machine: é apenas uma VM

Subir uma máquina pode ser desafiador às vezes, principalmente quando se deseja múltiplos contextos, com: nuvem, on-prem, VPS, local, etc. Por isso, ter algum norte na hora de subir infraestrutura é essencial para poupar muito tempo. 

E por vezes só queremos subir um teste em uma ambiente diferente para saber como a nossa aplicação vai se comportar e que vantagens podemos tirar ao migrar do on-prim para nuvem, e vice-versa.

## Objetivo

Mostrar os requisitos mínimos para subir uma máquina em diferentes plataformas e torná-las acessíveis.

## Requisitos básicos

- Instalado
    - Terraform 1.11 ou OpenTofu 1.9
    - libvirt
- Contas em provedores de nuvem
    - AWS
    - Azure
    - GCP
    - Linode
    - Digital Ocean

## Configuração

Há três váriaveis obrigatórias sem valor padrão necessárias para a execução correta dos módulos.

Além disso, garanta que a sua máquina está logada no provedor de nuvem.

## Uso

Basta incluir o módulo desejado e fornecer a variável de credencialmente, se necessário.

\
📍👦🏻😢👩🏼🙈