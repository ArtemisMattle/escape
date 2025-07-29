extends Node2D

@onready var settings: Control = $Settings


func _on_settings_pressed() -> void:
	settings.visible = true
