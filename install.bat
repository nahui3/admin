@echo off
REM Скрипт установки и настройки Django Admin проекта

setlocal enabledelayedexpansion

echo 🚀 Начинаем установку Django Admin проекта...

REM Проверка Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python не найден. Установите Python 3.8 или выше.
    exit /b 1
)

for /f "tokens=*" %%i in ('python --version') do set PYTHON_VERSION=%%i
echo ✓ Python найден: !PYTHON_VERSION!

REM Создание виртуального окружения
if not exist "venv" (
    echo 📦 Создаём виртуальное окружение...
    python -m venv venv
    echo ✓ Виртуальное окружение создано
) else (
    echo ✓ Виртуальное окружение уже существует
)

REM Активация виртуального окружения
echo 🔌 Активируем виртуальное окружение...
call venv\Scripts\activate.bat

REM Обновление pip
echo ⬆️  Обновляем pip...
python -m pip install --upgrade pip --quiet

REM Установка Django
echo 📥 Устанавливаем Django...
python -m pip install django --quiet
for /f "tokens=*" %%i in ('python -c "import django; print(django.get_version())"') do set DJANGO_VERSION=%%i
echo ✓ Django установлен: !DJANGO_VERSION!

REM Применение миграций
echo 🗄️  Применяем миграции базы данных...
python manage.py migrate --noinput
echo ✓ Миграции применены

REM Проверка наличия суперпользователя
echo 👤 Проверяем наличие суперпользователя...
python manage.py shell -c "from django.contrib.auth.models import User; exit(0 if User.objects.filter(is_superuser=True).exists() else 1)" >nul 2>&1
if errorlevel 1 (
    echo ⚠️  Суперпользователь не найден
    set /p CREATE_SUPERUSER="Создать суперпользователя сейчас? (y/n): "
    if /i "!CREATE_SUPERUSER!"=="y" (
        python manage.py createsuperuser
    ) else (
        echo 💡 Вы можете создать суперпользователя позже командой: python manage.py createsuperuser
    )
) else (
    echo ✓ Суперпользователь уже существует
)

echo.
echo ✅ Установка завершена!
echo.
echo Для запуска сервера используйте: run.bat
echo Или вручную: venv\Scripts\activate && python manage.py runserver

endlocal
