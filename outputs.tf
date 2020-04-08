output default_user {
  value = {
    gecos          = var.description,
    groups         = var.groups,
    homedir        = var.home != "" ? var.home : "/home/${var.name}",
    lock_passwd    = var.lock_passwd,
    name           = var.name,
    no_create_home = local.no_create_home,
    shell          = var.shell,
    ssh_import_id  = var.ssh_import_ids
  }
}

output add_user {
  value = {
    gecos               = var.description,
    homedir             = var.home != "" ? var.home : "/home/${var.name}",
    lock_passwd         = var.lock_passwd,
    name                = var.name,
    no_create_home      = local.no_create_home,
    shell               = var.shell,
    ssh_authorized_keys = local.ssh_authorized_keys,
    sudo                = var.sudo,
  }
}

output private_key {
  value = var.private_key != "" ? var.private_key : tls_private_key.this.0.private_key_pem
}

output public_key {
  value = var.public_key != "" ? var.public_key : tls_private_key.this.0.public_key_openssh
}
