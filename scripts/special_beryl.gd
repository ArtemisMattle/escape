extends State

var lastState: State
@export var jumpState: State
var bubble: Area2D

func _ready() -> void:
	for child in get_children():
		if child is Area2D:
			bubble = child
		else:
			push_error("Invalid bubble in Beryls SpecialState")
	if jumpState is not State:
		push_error("Invalid jumpState in Beryls SpecialState")

func stateInit() -> void:
	bubble.stateInit(jumpState)

func onEnter() -> void:
	nextState = lastState #returns to the last state, after handling onEnter
	bubble.position = character.position
	bubble.activate()
