extends State

var lastState: State
var bubble: Area2D

func _ready() -> void:
	for child in get_children():
		if child is Area2D:
			bubble = child
		else:
			push_error("Invalid bubble in Beryls SpecialState")

func onEnter() -> void:
	nextState = lastState #returns to the last state, after handling onEnter
	bubble.position = character.position
	bubble.activate()
