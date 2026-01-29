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

<img width="880" height="660" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/2_2.jpg?raw=true" />

Отбило блокировку, разблокировал

<img width="880" height="660" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/2_6.jpg?raw=true" />

## Задание 3

Удаление

<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/3_rm.jpg?raw=true" />

Восстановление 1

<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/3_restoration_1.jpg?raw=true" />

Восстановление 2

<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/3_restoration_2.jpg?raw=true" />

Грустно что терраформ не умеет в нормальную синхронизацию и важно в какой последовательности я восстанавливаю. Восстанавливал из яндекса + автогенерированные файлы бекапов.

Проверка тоже ок, кроме 1 параметра от яндекса:

<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/3_import_back.jpg?raw=true" />

[Ссылка на команды восстановления](https://github.com/erant-netology-courses/ter_homework_04/state_restored.txt)

## Задание 4*
Сделал как часть 2го, т.к. не понял что имелось в виду в ТЗ по 2 заданию.

## Задание 5*
Тут обнаружил, что не следовал конвенции по неймингу через underscore (привычка из разработки). Рефачить не стал.

1 хост:

<img width="1280" height="860" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/5_process1.jpg?raw=true" />

<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/5_ya_resources1.jpg?raw=true" />

4 хоста:
<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/5_process2.jpg?raw=true" />

<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/5_ya_resources2.jpg?raw=true" />

Очень долго создавал дополнительные 3 хоста. Я ушел на тренировку, придя с нее увидел что оно сожрало 150 рублей. Поэтому вопрос:

#### А что сейчас выгоднее - самому кластером управлять или от облака?

## Задание 6*
Попытался, проще создать вручную, чем долбаться с aws (который после событий в РФ все перестали использовать) и конфигурировать еще и их с токеном.

## Задание 7*
[Код для задания](https://github.com/erant-netology-courses/ter_homework_04/task_7.tf)

Результат работы:

<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/7_vault.jpg?raw=true" />

## Задание 8*
Разобрался. При помощи backend сохранить состояние одного модуля (сети), а после в создании ВМ указать что есть terraform_remote_state и обратиться к нему.