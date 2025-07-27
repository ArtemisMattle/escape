extends CharacterBody2D


var charMaxSpeed: float = 700.0
var charBaseAcceleration: float = 0.1
var charAcceleration: float = 0.1
var jumpVelocity: float = -100.0
@export var speedCurve: Curve
var charSpeed: float = 0.0
var gravityBaseMult: float = 1.0
var gravityMult: float = 1.0
var d: float

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * gravityMult * delta

	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if abs(velocity.x) <= 1.0:
		charSpeed = 0.0
	var direction := Input.get_axis("left", "right")
	if direction:
		if charSpeed <= 0.1:
			d = direction
		if d == direction:
			charSpeed = min(1.0, charSpeed + charAcceleration * delta)
		else:
			charSpeed = max(0.0, charSpeed - 3 * charAcceleration * delta)
	else:
		charSpeed = max(0.0, charSpeed - charAcceleration * delta)
	velocity.x = d * speedCurve.sample(charSpeed) * charMaxSpeed

	move_and_slide()
