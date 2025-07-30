extends Node2D
class_name Message

@onready var label: Label = $Panel/MarginContainer/Label
@onready var panel: PanelContainer = $Panel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var duration: float = 2
var maxheight: float = 100

func initiation(msg: String, colour: Color):
	label.text = msg
	panel.self_modulate = colour

func _process(delta: float) -> void:
	duration -= delta
	position.y -= maxheight * delta
	if duration < 0:
		animation_player.play("fadeOut")

func del() -> void:
	queue_free()
