# User

## Usage

```terraform
module provisioner {
  source  = "4ops/user/null"
  version = "1.0.0"
  name    = "provisioner"
}

module my_server_config {
  source       = "4ops/cloud-config/null"
  version      = "1.0.0"
  default_user = module.provisioner.default_user
}
```
