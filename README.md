# Проект спринта финального модуля

link to git -> 

## Запуск проекта:
```bash

docker-compose -f docker-compose.main.yaml -f docker-compose.db.yaml -f docker-compose.elk.yaml up --build
```

## Описание проекта:
Чекпоинт для создания шаблона сообщения (template), емайл\сокет рассылка и логирование и получение истории уведомлений (history) находится в сервисе Worker