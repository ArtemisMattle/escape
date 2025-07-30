extends Control

@onready var rebind: Control = $rebind

func _on_back_pressed() -> void:
	visible = false


func _on_rebind_pressed() -> void:
	rebind.visible = true
