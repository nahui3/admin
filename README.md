# Django Admin Project

Минимальный проект Django с настроенной административной панелью.

## Требования

- Python 3.8 или выше
- pip (менеджер пакетов Python)

## Установка и развёртывание

### 1. Клонирование или копирование проекта

Скопируйте все файлы проекта в нужную директорию:

```bash
git clone https://github.com/nahui3/admin.git
cd admin
```

### 2. Создание виртуального окружения

Рекомендуется использовать виртуальное окружение для изоляции зависимостей:

```bash
# Создание виртуального окружения
python3 -m venv venv

# Активация виртуального окружения
# На macOS/Linux:
source venv/bin/activate

# На Windows:
venv\Scripts\activate
```

### 3. Установка Django

Установите Django через pip:

```bash
pip install django
```

### 4. Применение миграций

Создайте базу данных SQLite и примените миграции:

```bash
python manage.py migrate
```

Эта команда создаст файл `db.sqlite3` с необходимой структурой базы данных.

### 5. Создание суперпользователя

Создайте административного пользователя для доступа к админ-панели:

```bash
python manage.py createsuperuser
```

Введите имя пользователя, email (опционально) и пароль.

### 6. Запуск сервера разработки

Запустите сервер разработки:

```bash
python manage.py runserver
```

Сервер будет доступен по адресу: `http://127.0.0.1:8000/`

### 7. Доступ к админ-панели

Откройте в браузере:

```
http://127.0.0.1:8000/admin/
```

Войдите используя учётные данные суперпользователя, созданного на шаге 5.

## Структура проекта

```
admin/
├── manage.py          # Утилита управления Django
├── settings.py         # Настройки проекта
├── urls.py            # URL-маршруты
├── wsgi.py            # WSGI конфигурация для развёртывания
├── asgi.py            # ASGI конфигурация для развёртывания
├── db.sqlite3         # База данных SQLite (создаётся после migrate)
├── venv/              # Виртуальное окружение (не в git)
└── README.md          # Этот файл
```

## Настройки

Основные настройки находятся в файле `settings.py`:

- **SECRET_KEY**: Секретный ключ для криптографии (измените в продакшене!)
- **DEBUG**: Режим отладки (установите `False` в продакшене)
- **ALLOWED_HOSTS**: Разрешённые хосты (укажите домен в продакшене)
- **DATABASES**: Настройки базы данных (по умолчанию SQLite)
- **LANGUAGE_CODE**: Язык интерфейса (по умолчанию 'ru-ru')
- **TIME_ZONE**: Часовой пояс (по умолчанию 'Europe/Moscow')

## Развёртывание в продакшене

Для развёртывания в продакшене:

1. Установите `DEBUG = False` в `settings.py`
2. Укажите `ALLOWED_HOSTS = ['yourdomain.com']`
3. Сгенерируйте новый `SECRET_KEY` (можно использовать `python manage.py shell` и выполнить `from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())`)
4. Настройте статические файлы: `python manage.py collectstatic`
5. Используйте production-ready веб-сервер (например, Gunicorn + Nginx)
6. Рассмотрите использование PostgreSQL вместо SQLite для продакшена

## Полезные команды

```bash
# Создать миграции (если добавите свои модели)
python manage.py makemigrations

# Применить миграции
python manage.py migrate

# Создать суперпользователя
python manage.py createsuperuser

# Запустить сервер разработки
python manage.py runserver

# Запустить сервер на другом порту
python manage.py runserver 8080

# Проверить конфигурацию проекта
python manage.py check

# Открыть Django shell
python manage.py shell
```

## Дополнительная информация

- [Документация Django](https://docs.djangoproject.com/)
- [Документация Django Admin](https://docs.djangoproject.com/en/stable/ref/contrib/admin/)
