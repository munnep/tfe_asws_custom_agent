terraform {
  cloud {
    hostname     = "patrick-tfe44.tf-support.hashicorpdemo.com"
    organization = "test"

    workspaces {
      name = "test-custom-agent"
    }
  }
}


resource "null_resource" "test" {
  provisioner "local-exec" {
    command = "az --version"
  }
}
