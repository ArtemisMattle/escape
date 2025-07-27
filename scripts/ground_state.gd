extends State

@export var jumpState: State
@export var fallState: State
@export var jumpMult: float = 7.0
@export var accMult: float = 21.0
@onready var coyoteTimer: Timer = $coyote


func onEnter() -> void:
	if jumpState is not State:
		push_error("jumpState " + jumpState.name + " for " + name + " is not a valid State")
	if fallState is not State:
		push_error("fallState " + fallState.name + " for " + name + " is not a valid State")
	character.charAcceleration = accMult * character.charBaseAcceleration

func stateInput(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		nextState = jumpState
		character.velocity.y = jumpMult * character.jumpVelocity

func stateProcess(delta: float) -> void:
	if not character.is_on_floor() and coyoteTimer.is_stopped():
		coyoteTimer.start()

func onExit() -> void:
	character.charAcceleration = character.charBaseAcceleration

func coyote() -> void:
	if nextState == null:
		nextState = fallState
