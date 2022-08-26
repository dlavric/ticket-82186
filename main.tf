terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.8.2"
    }
  }
}

provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = "hvs.D2hCccLt1fUWJ9oSgTzInw8n"

  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id   = "9429b417-41ef-f3f0-9cf7-8f9da6060e75"
      secret_id = "39128b36-f37a-178d-406b-275f4ef48af7"
    }
  }
}

resource "vault_auth_backend" "approle" {
  type = "approle"
}

data "vault_approle_auth_backend_role_id" "role" {
  backend   = vault_auth_backend.approle.path
  role_name = "my-role"
}

output "role-id" {
  value = data.vault_approle_auth_backend_role_id.role.role_id
}

