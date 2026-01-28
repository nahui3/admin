# Используем официальный образ Python
FROM python:3.11-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Копируем requirements.txt
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Копируем код проекта
COPY . .

# Создаем директорию для файлов (будет перезаписана volume, но нужно для начальной инициализации)
RUN mkdir -p /app/files/android /app/files/ios /app/files/web /app/media

# Открываем порт
EXPOSE 8000

# Запускаем сервер (миграции выполняются в docker-compose.yml)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
