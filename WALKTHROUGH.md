# Walkthrough - Terraform para XCP-ng (Xen Orchestra)

Criei uma configuração completa do Terraform para você gerenciar seu ambiente XCP-ng através do Xen Orchestra.

## Arquivos Criados

### 1. [versions.tf](file:///Users/ismaelalves/terraform/versions.tf)
Define o provider `xenorchestra`. Tivemos que ajustar para usar a versão mais recente compatível automaticamente, pois versões antigas (0.29.0) estavam dando erro.

### 2. [variables.tf](file:///Users/ismaelalves/terraform/variables.tf)
Define as variáveis necessárias para conectar no seu Xen Orchestra e escolher onde criar as VMs. As variáveis são:
- `xo_url`: URL do seu Xen Orchestra (ex: `wss://xo.local`)
- `xo_username`: Seu usuário
- `xo_password`: Sua senha
- `pool_id`: O nome do Pool
- `network_name`: O nome da rede (ex: "Pool-wide network associated with eth0")
- `template_name`: O nome do template a ser clonado
- `sr_name`: O nome do Storage Repository (SR) para o disco

### 3. [main.tf](file:///Users/ismaelalves/terraform/main.tf)
Contém a configuração principal do provider e um exemplo básico de VM (`xenorchestra_vm`). Ele busca automaticamente os IDs do Pool, Template, SR e Rede baseados nos nomes que você fornecer.

### 4. [examples.tf](file:///Users/ismaelalves/terraform/examples.tf)
Aqui estão os exemplos avançados que você pediu:

#### Múltiplas VMs (Loop)
Mostra como criar várias VMs de uma vez usando `count = 3`. Isso criará `Web-Server-1`, `Web-Server-2`, etc.

#### Cloud-init
Mostra como injetar configurações no boot da VM. O exemplo configura:
- Nome do host (`db-server`)
- Cria um usuário `admin_user` com chave SSH e sudo sem senha
- Instala pacotes (`htop`, `curl`, `vim`)
- Roda comandos iniciais

## Como Usar

1. **Crie um arquivo `terraform.tfvars`** com suas configurações reais (não comite este arquivo se tiver senhas reais de produção):

```hcl
xo_url        = "wss://192.168.1.100" # URL do seu XO
xo_username   = "admin@admin.net"
xo_password   = "sua-senha-aqui"
pool_id       = "Pool Principal" # Nome exato do seu Pool
network_name  = "Pool-wide network associated with eth0" # Nome da sua rede
template_name = "Ubuntu 20.04" # Nome do seu template
sr_name       = "Local storage" # Nome do seu SR
```

2. **Planeje a execução**:
```bash
terraform plan
```

3. **Aplique**:
```bash
terraform apply
```

Isso criará as VMs definidas no `main.tf` e `examples.tf`.
