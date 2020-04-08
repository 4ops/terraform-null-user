terraform {
  required_version = ">= 0.12"

  required_providers {
    tls = ">= 2.1"
  }
}

resource tls_private_key this {
  count       = var.private_key != "" ? 0 : 1
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

locals {
  home                = var.home != "" ? var.home : "/home/${var.name}"
  no_create_home      = ! var.create_home
  ssh_authorized_keys = compact(concat([var.public_key], var.authorized_keys, tls_private_key.this.*.public_key_openssh))
}
