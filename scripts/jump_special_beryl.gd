extends State

@export var jumpState: State
@export var bubble: Area2D
var bubbleSpeed: Vector2 = Vector2(0, 150)
var bubbleOffset: Vector2 = Vector2(0, 375)
var bubbleBounce: float = 400
var bubbleRecoil: float = 70

var jumpForce: float = 777


func _ready() -> void:
	if bubble is not Area2D:
		push_error("Invalid bubble in Beryls JumpSpecialState")
	if jumpState is not State:
		push_error("Invalid jumpState in Beryls JumpSpecialState")

func stateInit() -> void:
	bubble.stateInit(jumpState)

func onEnter() -> void:
	nextState = jumpState
	character.velocity.y -= jumpForce
	machine.specialAvailable = false
	bubble.position = character.position + Vector2(character.facing * bubbleOffset.x, bubbleOffset.y)
	bubble.velocity = bubbleSpeed
	bubble.velocity.x = character.velocity.x
	bubble.bounceVel = bubbleBounce
	bubble.recoil = bubbleRecoil
	bubble.activate()
