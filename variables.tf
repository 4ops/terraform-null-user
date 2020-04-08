variable name {
  type = string
}

variable description {
  default = ""
}

variable home {
  default = ""
}

variable groups {
  default = []
}

variable private_key {
  default = ""
}

variable public_key {
  default = ""
}

variable authorized_keys {
  default = []
}

variable create_home {
  default = true
}

variable shell {
  default = "/bin/bash"
}

variable ssh_import_ids {
  default = []
}

variable lock_passwd {
  default = true
}

variable sudo {
  default = []
}
