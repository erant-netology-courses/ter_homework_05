output "subnet" {
  value = yandex_vpc_subnet.my-module-subnet[*]
  description = "List of subnets"
}
