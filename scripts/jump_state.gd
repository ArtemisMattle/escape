extends State

@export var fallState: State
var gravityMult: float = 0.5

func onEnter() -> void:
	character.gravityMult = gravityMult
	if fallState is not State:
		push_error("fallState " + fallState.name + " for " + name + " is not a valid State")

func stateInput(event: InputEvent) -> void:
	if event.is_action_released("jump") or event.is_action_pressed("down"):
		character.velocity.y = 0.0
		nextState = fallState

func stateProcess(delta: float) -> void:
	if character.velocity.y > 0.0:
		nextState = fallState

func onExit() -> void:
	character.gravityMult = character.gravityBaseMult
   
