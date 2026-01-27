# Развёртывание в продакшене

Для развёртывания в продакшене выполните следующие шаги:

## 1. Настройка settings.py

Откройте `configs/settings.py` и внесите следующие изменения:

```python
# Отключите режим отладки
DEBUG = False

# Укажите разрешённые хосты
ALLOWED_HOSTS = ['yourdomain.com', 'www.yourdomain.com']

# Сгенерируйте новый SECRET_KEY
# Можно использовать команду:
# python manage.py shell
# from django.core.management.utils import get_random_secret_key
# print(get_random_secret_key())
SECRET_KEY = 'ваш-новый-секретный-ключ'
```

## 2. Настройка статических файлов

Добавьте в `configs/settings.py`:

```python
STATIC_ROOT = BASE_DIR / 'staticfiles'
```

Затем соберите статические файлы:

```bash
python manage.py collectstatic
```

## 3. Настройка базы данных

Для продакшена рекомендуется использовать PostgreSQL:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'your_db_name',
        'USER': 'your_db_user',
        'PASSWORD': 'your_db_password',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
```

Установите psycopg2:

```bash
pip install psycopg2-binary
```

## 4. Использование production-ready веб-сервера

### С Gunicorn

Установите Gunicorn:

```bash
pip install gunicorn
```

Запуск:

```bash
gunicorn configs.wsgi:application --bind 0.0.0.0:8000
```

### С uWSGI

Установите uWSGI:

```bash
pip install uwsgi
```

Создайте конфигурационный файл `uwsgi.ini`:

```ini
[uwsgi]
module = configs.wsgi:application
master = true
processes = 4
socket = /tmp/admin.sock
chmod-socket = 666
vacuum = true
die-on-term = true
```

## 5. Настройка Nginx

Пример конфигурации Nginx:

```nginx
server {
    listen 80;
    server_name yourdomain.com;

    location /static/ {
        alias /path/to/your/project/staticfiles/;
    }

    location / {
        proxy_pass http://unix:/tmp/admin.sock;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## 6. Использование HTTPS

Настройте SSL сертификат (например, через Let's Encrypt) и обновите настройки:

```python
SECURE_SSL_REDIRECT = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
```

## 7. Логирование

Настройте логирование в `configs/settings.py`:

```python
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'file': {
            'level': 'ERROR',
            'class': 'logging.FileHandler',
            'filename': BASE_DIR / 'logs' / 'django.log',
        },
    },
    'loggers': {
        'django': {
            'handlers': ['file'],
            'level': 'ERROR',
            'propagate': True,
        },
    },
}
```

## 8. Резервное копирование

Настройте регулярное резервное копирование базы данных:

```bash
# Для SQLite
cp db.sqlite3 backups/db_$(date +%Y%m%d_%H%M%S).sqlite3

# Для PostgreSQL
pg_dump -U user dbname > backups/db_$(date +%Y%m%d_%H%M%S).sql
```

## 9. Мониторинг

Рассмотрите использование инструментов мониторинга:
- Sentry для отслеживания ошибок
- Prometheus + Grafana для метрик
- Log aggregation системы
