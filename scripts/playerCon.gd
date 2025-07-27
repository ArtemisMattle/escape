extends CharacterBody2D


var charMaxSpeed: float = 700.0
var charBaseAcceleration: float = 250.0
var charAcceleration: float = 250.0
var jumpVelocity: float = -100.0
var gravityBaseMult: float = 1.0
var gravityMult: float = 1.0
var d: float

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * gravityMult * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * charMaxSpeed, charAcceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, 3.0 * charAcceleration * delta)

	move_and_slide()
