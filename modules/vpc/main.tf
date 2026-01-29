terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.8.4"
}

resource "yandex_vpc_network" "my-module-network" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "my-module-subnet" {
  count = length(var.subnets)

  name           = "vpc-${var.vpc_name}-subnet-${count.index}"
  zone           = var.subnets[count.index].zone
  network_id     = yandex_vpc_network.my-module-network.id
  v4_cidr_blocks = var.subnets[count.index].v4_cidr_blocks
}
