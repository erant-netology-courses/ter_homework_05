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

Checkov - мегабагованная штука, особенно в сравнении с линтерами в "опытных" ЯП, многим из которых понадобилось более 5-10 лет, чтобы делать нормальный линт
```
docker run --rm -v "%cd%:/src" -w /src bridgecrew/checkov --directory /src --quiet
```

<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/3_4_checkov.jpg?raw=true" />

Tflint - получше

<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/3_4_tflint.jpg?raw=true" />

Apply - Очень большой, поэтому вот концовка

<img width="1280" height="360" alt="image" src="https://github.com/erant-netology-courses/ter_homework_04/blob/main/3_5_apply.jpg?raw=true" />
