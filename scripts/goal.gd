extends Area2D

@export var characters: Array[CharacterBody2D]

@onready var label_5: Label = $Label5



func _on_body_entered(body: Node2D) -> void:
	if characters.has(body):
		characters.erase(body)
		if characters.is_empty():
			label_5.visible = true
