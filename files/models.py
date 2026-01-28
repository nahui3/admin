from django.db import models
from django.core.validators import FileExtensionValidator
from django.conf import settings
import os
import shutil


class InterfaceFile(models.Model):
    """Модель для хранения информации о файлах интерфейсов"""
    
    PLATFORM_CHOICES = [
        ('android', 'Android'),
        ('ios', 'iOS'),
        ('web', 'Web'),
    ]
    
    name = models.CharField(max_length=255, verbose_name='Название файла')
    platform = models.CharField(
        max_length=10,
        choices=PLATFORM_CHOICES,
        verbose_name='Платформа'
    )
    file = models.FileField(
        upload_to='files/%Y/%m/%d/',
        verbose_name='Файл',
        validators=[FileExtensionValidator(
            allowed_extensions=['json', 'xml', 'yaml', 'yml', 'txt', 'zip', 'tar', 'gz']
        )]
    )
    description = models.TextField(blank=True, verbose_name='Описание')
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='Дата создания')
    updated_at = models.DateTimeField(auto_now=True, verbose_name='Дата обновления')
    is_active = models.BooleanField(default=True, verbose_name='Активен')
    
    class Meta:
        verbose_name = 'Файл интерфейса'
        verbose_name_plural = 'Файлы интерфейсов'
        ordering = ['-created_at']
    
    def __str__(self):
        return f"{self.name} ({self.platform})"
    
    def save(self, *args, **kwargs):
        """Переопределяем save для копирования файла в нужную директорию"""
        super().save(*args, **kwargs)
        
        # Путь к общей директории файлов (для Go сервиса)
        files_base_dir = getattr(settings, 'FILES_BASE_DIR', None)
        if not files_base_dir:
            # Fallback на относительный путь
            files_base_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), '..', 'files')
        
        platform_dir = os.path.join(str(files_base_dir), self.platform)
        
        # Создаем директорию если её нет
        os.makedirs(platform_dir, exist_ok=True)
        
        # Копируем файл в директорию платформы
        if self.file:
            destination_path = os.path.join(platform_dir, os.path.basename(self.file.name))
            shutil.copy2(self.file.path, destination_path)
