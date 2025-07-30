extends CharacterBody2D


var charMaxSpeed: float = 700.0
var charBaseAcceleration: float = 250.0
var charAcceleration: float = 250.0
var jumpVelocity: float = -100.0
var gravityBaseMult: float = 1.0
var gravityMult: float = 1.0
var facing: float = 1.0 #1.0 for right, -1.0 for left

var active: bool = false

var resetPos: Vector2

@onready var stateMachine: StateMachine = $charStateMachine
@onready var skeleton: Skeleton2D = $Skeleton2D
@onready var targets: Node2D = $ikTargets
@onready var msg: PackedScene = preload("res://scenes/message.tscn")
@export var charColour: Color = Color.WHITE
@export var messageOffset: Vector2 = Vector2(0, -300)

func _ready() -> void:
	SignalBus.takeDamage.connect(reset)
	SignalBus.deactivate.connect(deactivate)
	resetPos = position

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * gravityMult * delta
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if active:
		var direction := Input.get_axis("left", "right")
		if direction:
			if facing != sign(direction):
				facing = sign(direction)
				changeFacing()
			velocity.x = move_toward(velocity.x, direction * charMaxSpeed, charAcceleration * delta)
		else:
			velocity.x = move_toward(velocity.x, 0.0, 3.0 * charAcceleration * delta)

	move_and_slide()

func changeFacing() -> void:
	scale.x = - scale.x

func reset(character : CharacterBody2D) -> void:
	if character == self:
		position = resetPos
		var message: Message = msg.instantiate()
		message.position = position + messageOffset
		stateMachine.add_child(message)
		message.initiation("I should be more careful", charColour)


func _on_activate() -> void:
	active = true
	SignalBus.deactivate.emit(self)

func deactivate(except: CharacterBody2D) -> void:
	if except != self:
		active = false
