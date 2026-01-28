from django.contrib import admin
from .models import InterfaceFile


@admin.register(InterfaceFile)
class InterfaceFileAdmin(admin.ModelAdmin):
    list_display = ('name', 'platform', 'file', 'is_active', 'created_at', 'updated_at')
    list_filter = ('platform', 'is_active', 'created_at')
    search_fields = ('name', 'description')
    readonly_fields = ('created_at', 'updated_at')
    fieldsets = (
        ('Основная информация', {
            'fields': ('name', 'platform', 'file', 'description', 'is_active')
        }),
        ('Метаданные', {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',)
        }),
    )
