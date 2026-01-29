#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = "develop"
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop_a" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = "develop-ru-central1-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

module "my_vpc_module" {
  vpc_name = "develop_vpc"
  source = "./modules/vpc"

  subnets = [
    { zone = "ru-central1-a", v4_cidr_blocks = ["10.0.1.0/24"] },
    { zone = "ru-central1-b", v4_cidr_blocks = ["10.0.2.0/24"] }
  ]
}

# checkov:skip=CKV_TF_1,CKV_TF_2,CKV_YC_19:Это локальный модуль; Безопасность уже безопасна в модуле
module "example" {
  source = "./modules/mysql_cluster"
  cluster_name = "example"
  network_id = module.my_vpc_module.subnet[0].network_id
  zone = "ru-central1-b"
  subnet_id = module.my_vpc_module.subnet[1].id
  HA  = false
}

# checkov:skip=CKV_TF_1,CKV_TF_2:Это локальный модуль; Безопасность уже безопасна в модуле
module "db_cluster" {
  source = "./modules/mysql_db"
  db_name = "example_db"
  db_username = "Notna"
  cluster_id = module.example.cluster.id
}

# checkov:skip=CKV_TF_1,CKV_TF_2:Контролируется хэшем коммита
module "test-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=c59b04f9428f89fdce7b2e2fbccdd284c6f9f6a2"
  env_name       = "develop"
  # network_id     = yandex_vpc_network.develop.id
  # subnet_zones   = ["ru-central1-a","ru-central1-b"]
  # subnet_ids     = [yandex_vpc_subnet.develop_a.id,yandex_vpc_subnet.develop_b.id]
  network_id     = module.my_vpc_module.subnet[0].network_id
  subnet_zones   = ["ru-central1-a","ru-central1-b"]
  subnet_ids     = [module.my_vpc_module.subnet[0].id, module.my_vpc_module.subnet[1].id]
  instance_name  = "webs"
  instance_count = 2
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    project = "marketing"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}
# checkov:skip=CKV_TF_1,CKV_TF_2:Контролируется хэшем коммита
module "example-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=c59b04f9428f89fdce7b2e2fbccdd284c6f9f6a2"
  env_name       = "stage"
  # network_id     = yandex_vpc_network.develop.id
  # subnet_zones   = ["ru-central1-a"]
  # subnet_ids     = [yandex_vpc_subnet.develop_a.id]
  network_id     = module.my_vpc_module.subnet[0].network_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.my_vpc_module.subnet[0].id]
  instance_name  = "web-stage"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    project = "analytics"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}



#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    ssh_key = var.public_key
  }
}