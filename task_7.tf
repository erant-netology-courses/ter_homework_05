data "vault_generic_secret" "vault_example_2" {
  path = "secret/example"
}

output "vault_example_2" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example_2.data)}"
}

resource "vault_generic_secret" "my_vault_secret" {
  path = "secret/terrasecret"

  data_json = jsonencode({
    username = "second"
    password = "secret"
  })
}