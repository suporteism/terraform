# Exemplo 1: Criando multiplas VMs usando "count" (Loop)
resource "xenorchestra_vm" "web_cluster" {
  count      = 3 # Cria 3 VMs idênticas
  memory_max = 2147483648 # 2GB
  cpus       = 2
  name_label = "Web-Server-${count.index + 1}" # Web-Server-1, Web-Server-2, etc.
  template   = data.xenorchestra_template.template.id
  
  network {
    network_id = data.xenorchestra_network.net.id
  }

  disk {
    sr_id      = data.xenorchestra_sr.sr.id
    name_label = "Web-Disk"
    size       = 21474836480 # 20GB
  }

  tags = ["producao", "web", "terraform"]
}

# Exemplo 2: Usando Cloud-init para configurar a VM automaticamente (instalar pacotes, criar usuários)
resource "xenorchestra_vm" "database" {
  memory_max = 4294967296 # 4GB
  cpus       = 4
  name_label = "Database-Server"
  template   = data.xenorchestra_template.template.id

  network {
    network_id = data.xenorchestra_network.net.id
  }

  disk {
    sr_id      = data.xenorchestra_sr.sr.id
    name_label = "DB-Disk"
    size       = 53687091200 # 50GB
  }

  tags = ["banco-de-dados", "interno"]

  # Configuração do Cloud-init
  cloud_config = <<EOF
#cloud-config
hostname: db-server
users:
  - name: admin_user
    ssh-authorized-keys:
      - ssh-rsa AAAAB3Nza... (sua chave publica aqui)
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: sudo
    shell: /bin/bash
packages:
  - htop
  - curl
  - vim
runcmd:
  - echo "Bem-vindo ao servidor configurado via Terraform no XCP-ng" > /etc/motd
EOF
}
