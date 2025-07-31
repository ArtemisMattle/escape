extends Sprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@export var specialState: State
var speed: float = 10000
var velocity: Vector2

func initi() -> void:
	velocity = get_global_mouse_position() - position
	velocity = velocity.normalized()

func _physics_process(delta: float) -> void:
	position += velocity * delta * speed
	if ray_cast_2d.get_collider() is TileMapLayer:
		specialState.anchor(position)
		set_physics_process(false)
