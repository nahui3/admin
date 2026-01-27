# Полезные команды Django

## Основные команды

### Создание миграций

Если вы добавили свои модели, создайте миграции:

```bash
python manage.py makemigrations
```

### Применение миграций

Примените миграции к базе данных:

```bash
python manage.py migrate
```

### Создание суперпользователя

Создайте административного пользователя:

```bash
python manage.py createsuperuser
```

### Запуск сервера разработки

Запустите сервер разработки:

```bash
python manage.py runserver
```

Запуск на другом порту:

```bash
python manage.py runserver 8080
```

Запуск на всех интерфейсах:

```bash
python manage.py runserver 0.0.0.0:8000
```

### Проверка конфигурации

Проверьте конфигурацию проекта на ошибки:

```bash
python manage.py check
```

### Django shell

Откройте интерактивную оболочку Django:

```bash
python manage.py shell
```

Пример использования:

```python
from django.contrib.auth.models import User
users = User.objects.all()
print(users)
```

## Работа с приложениями

### Создание нового приложения

```bash
python manage.py startapp myapp
```

### Список установленных приложений

```bash
python manage.py showmigrations
```

## Работа с пользователями

### Создание пользователя через shell

```bash
python manage.py shell
```

```python
from django.contrib.auth.models import User
user = User.objects.create_user('username', 'email@example.com', 'password')
user.is_superuser = True
user.is_staff = True
user.save()
```

### Изменение пароля пользователя

```bash
python manage.py changepassword username
```

## Статические файлы

### Сбор статических файлов

```bash
python manage.py collectstatic
```

### Поиск статических файлов

```bash
python manage.py findstatic admin/css/base.css
```

## База данных

### Просмотр SQL для миграции

```bash
python manage.py sqlmigrate app_name migration_number
```

### Сброс базы данных (удаление всех данных)

⚠️ **Внимание**: Эта команда удалит все данные!

```bash
rm db.sqlite3
python manage.py migrate
```

## Отладка

### Показать все URL-маршруты

```bash
python manage.py show_urls
```

Или установите django-extensions:

```bash
pip install django-extensions
```

Затем добавьте в `INSTALLED_APPS`:

```python
INSTALLED_APPS = [
    # ...
    'django_extensions',
]
```

## Дополнительные команды

### Создание пустых миграций

```bash
python manage.py makemigrations --empty app_name
```

### Откат миграции

```bash
python manage.py migrate app_name previous_migration_name
```

### Показать все команды

```bash
python manage.py help
```

### Помощь по конкретной команде

```bash
python manage.py help migrate
```
