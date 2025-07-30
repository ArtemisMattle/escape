extends Node2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var speed: float = 250
var timeScale: float = 1

func _ready() -> void:
	animation_player.play("walk")

func _physics_process(delta: float) -> void:
	position.x += delta * speed * sign(scale.x) * timeScale

func checkPath() -> void:
	if ray_cast_2d.get_collider() is TileMapLayer:
		scale.x *= -1

func changeSpeed() -> void:
	timeScale = randf_range(0.9, 1.1)
	animation_player.speed_scale = timeScale
