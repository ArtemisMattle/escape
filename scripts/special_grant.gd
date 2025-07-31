extends State

var lastState: State
@export var prothesis: Bone2D
@export var hook: Sprite2D
@export var fakeHook: Sprite2D
@export var climbState: State
@export var jumpState: State

func stateProcess(delta: float) -> void:
	prothesis.look_at(character.mousePos)

func stateInput(event: InputEvent) -> void:
	if event.is_action_pressed("special"):
		fire()
	if event.is_action_pressed("jump"):
		nextState = jumpState

func fire() -> void:
	fakeHook.visible = false
	hook.global_position = fakeHook.global_position
	hook.rotation = fakeHook.rotation
	hook.visible = true
	hook.initi()
	hook.set_physics_process(true)

func anchor(pos: Vector2) -> void:
	climbState.anchor = pos
	nextState = climbState
