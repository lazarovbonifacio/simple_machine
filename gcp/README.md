# Como subir uma máquina no GCP?

Vamos juntar os requisitos imediatos para a tarefa

## Requisitos

- gcloud CLI
- ID do projeto

# Passo-a-passo

1. habilitar Compute Engine API e Conta de faturamento
2. Provisionar infra
3. Validação via HTTP e Console

# Comandos

- Autenticação no GCP: `gcloud auth application-default login`
- Primeiro projeto, definir cota: `gcloud auth application-default set-quota-project <PROJECT_ID>`

# Referências

- https://cloud.google.com/sdk/docs/install?hl=pt-br#deb