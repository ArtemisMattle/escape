extends CharacterBody2D


var charMaxSpeed: float = 700.0
var charBaseAcceleration: float = 250.0
var charAcceleration: float = 250.0
var jumpVelocity: float = -100.0
var gravityBaseMult: float = 1.0
var gravityMult: float = 1.0
var facing: bool = true #true for right, false for left

@onready var stateMachine: StateMachine = $charStateMachine
@onready var skeleton: Skeleton2D = $Skeleton2D
@onready var targets: Node2D = $ikTargets

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * gravityMult * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		if facing != (direction > 0):
			facing = direction > 0
			updateFacing()
		velocity.x = move_toward(velocity.x, direction * charMaxSpeed, charAcceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, 3.0 * charAcceleration * delta)

	move_and_slide()

func updateFacing() -> void:
	if facing:
		scale.x = abs(scale.x)
	else:
		scale.x = - abs(scale.x)
