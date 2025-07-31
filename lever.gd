extends Node2D

@export var toActivate: Array[Path2D]
var entered: bool = false
@export var message: String
@onready var label_3: Label = $Node/Label3



func _ready() -> void:
	label_3.text = message
	label_3.position = position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		entered = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		entered = false


func _input(event: InputEvent) -> void:
	if entered:
		if event.is_action_pressed("use"):
			scale.x = -scale.x
			activate()

func activate() -> void:
	for a in toActivate:
		a.activate()
