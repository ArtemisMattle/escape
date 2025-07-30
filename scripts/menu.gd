extends Node2D

@onready var settings: Control = $Settings
@onready var credits: Control = $Credits


func _on_settings_pressed() -> void:
	settings.visible = true


func _on_credits_pressed() -> void:
	credits.visible = true

func _on_return_pressed() -> void:
	credits.visible = false
