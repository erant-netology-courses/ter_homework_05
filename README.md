# ter_homework_05

## Задание 1
```
(terraform_unused_declarations)
(terraform_module_pinned_source)
(terraform_required_providers)
Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
```

## Задание 2
Настроил бекенд для терраформ стейта:

<img width="880" height="660" alt="image" src="https://github.com/erant-netology-courses/ter_homework_05/blob/main/2_2.jpg?raw=true" />

Отбило блокировку, разблокировал

<img width="880" height="660" alt="image" src="https://github.com/erant-netology-courses/ter_homework_05/blob/main/2_6.jpg?raw=true" />

## Задание 4
<img width="880" height="660" alt="image" src="https://github.com/erant-netology-courses/ter_homework_05/blob/main/4.JPG?raw=true" />

## Задание 5*
```
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
```
## Задание 6*
Не стал делать, полноценное CI/CD делаю на работе в данный момент (не для терраформа).

## Задание 7*
Я знаю, что рут модуль должен быть в своем проекте, но добавил его в эту репу в подмодуль.

[Код для задания](https://github.com/erant-netology-courses/ter_homework_05/tree/main/modules/backend)
