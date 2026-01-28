provider "xenorchestra" {
  url      = var.xo_url
  username = var.xo_username
  password = var.xo_password
  # If you are using a self-signed certificate on XO, you might need:
  # insecure = true
}

data "xenorchestra_pool" "pool" {
  name_label = var.pool_id
}

data "xenorchestra_template" "template" {
  name_label = var.template_name
}

data "xenorchestra_sr" "sr" {
  name_label = var.sr_name
  pool_id    = data.xenorchestra_pool.pool.id
}

data "xenorchestra_network" "net" {
  name_label = var.network_name
  pool_id    = data.xenorchestra_pool.pool.id
}

resource "xenorchestra_vm" "example_vm" {
  memory_max = 2147483648 # 2GB
  cpus       = 2
  name_label = "Terraform-Example-VM"
  template   = data.xenorchestra_template.template.id
  
  # Network configuration using the looked-up network
  network {
    network_id = data.xenorchestra_network.net.id
  }

  disk {
    sr_id      = data.xenorchestra_sr.sr.id
    name_label = "Terraform-Example-Disk"
    size       = 32212254720 # 30GB
  }
  
  # Wait for the VM to be reported as up and running relative to the
  # guest agent.
  wait_for_ip = true
}
