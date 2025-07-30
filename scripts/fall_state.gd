extends State

@export var groundState: State
@export var jumpSpecial: State
var gravityMult : float = 2.5
var storedEvent : InputEvent

func onEnter() -> void:
	if groundState is not State:
		push_error("groundState " + groundState.name + " for " + name + " is not a valid State")

func stateInput(event: InputEvent) -> void:
	if event.is_action_pressed("down"):
		character.gravityMult = gravityMult
	storedEvent = event
	if event.is_action("special") and machine.specialAvailable:
		nextState = jumpSpecial

func stateProcess(_delta: float) -> void:
	if character.velocity.y <= 0.1 and character.is_on_floor():
		nextState = groundState

func onExit() -> void:
	character.gravityMult = character.gravityBaseMult
	if storedEvent != null:
		nextState.stateInput(storedEvent)
