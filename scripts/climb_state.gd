extends State

var anchor: Vector2
var speed: float = 80000
var dir: float = 0
@export var hook: Sprite2D
@export var fakeHook: Sprite2D
@export var jumpState: State

func onEnter() -> void:
	character.gravityMult = 0

func stateInput(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		dir = 1
	if event.is_action_pressed("down"):
		dir = -1
	if event.is_action_released("down") or event.is_action_released("up"):
		dir = 0
	if event.is_action_pressed("jump"):
		nextState = jumpState

func stateProcess(delta) -> void:
	
	character.velocity = (anchor - character.position).normalized() * speed * delta * dir
		
	character.move_and_slide()
	

func onExit() -> void:
	character.gravityMult = 1
	hook.visible = false
	fakeHook.visible = true
