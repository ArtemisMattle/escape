extends State

var lastState: State
@export var jumpState: State
var bubble: Area2D
var bubbleSpeed: Vector2 = Vector2(500, -20)
var bubbleOffset: Vector2 = Vector2(100, 0)
var bubbleBounce: float = 500
var bubbleRecoil: float = 30


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
	machine.specialAvailable = false
	bubble.position = character.position + Vector2(character.facing * bubbleOffset.x, bubbleOffset.y)
	bubble.velocity = bubbleSpeed
	bubble.velocity.x *= character.facing
	bubble.bounceVel = bubbleBounce
	bubble.recoil = bubbleRecoil
	bubble.activate()
