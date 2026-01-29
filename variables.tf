###cloud vars

variable "public_key" {
  type    = string
  default = "ключ"
}

variable "ip_address" {
  type = string
  description = "ip-адрес"

  validation {
    condition = can(cidrhost("${var.ip_address}/32", 0))
    error_message = "Ошибка в cidr"
  }

  validation {
    condition = can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", var.ip_address))
    error_message = "Неверный IP"
  }
}
# cidrhost("192.168.0.1/32", 0)
# cidrhost("1920.1680.0.1/32", 0)
# regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", "192.168.0.1")
# regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", "1920.1680.0.1")

variable "ip_adresses" {
  type = list(string)
  description = "список ip-адресов"

  validation {
    condition = alltrue([
      for ip in var.ip_adresses :
      can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", ip)) &&
      alltrue([for octet in split(".", ip) : tonumber(octet) >= 0 && tonumber(octet) <= 255])
    ])
    error_message = "Все IP должны быть в формате X.X.X.X, где X=0-255"
  }
}
# alltrue([for ip in ["192.168.0.1", "1.1.1.1", "127.0.0.1"] : can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", ip)) && alltrue([for octet in split(".", ip) : tonumber(octet) >= 0 && tonumber(octet) <= 255])])
# alltrue([for ip in ["192.168.0.1", "1.1.1.1", "1270.0.0.1"] : can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", ip)) && alltrue([for octet in split(".", ip) : tonumber(octet) >= 0 && tonumber(octet) <= 255])])

variable "any_string" {
  type = string
  description="любая строка"

  validation {
    condition = var.any_string == lower(var.any_string)
    error_message = "Есть символы верхнего регистра"
  }
}
# "Asvb" == lower("Asvb")
# "test" == lower("test")

variable "obj_structure" {
  type = object({
    Dunkan = optional(bool)
    Connor = optional(bool)
  })
  description="Who is better Connor or Duncan?"

  default = {
    Dunkan = true
    Connor = false
  }

  validation {
    error_message = "There can be only one MacLeod"
    condition = var.obj_structure.Dunkan != var.obj_structure.Connor
  }
}
