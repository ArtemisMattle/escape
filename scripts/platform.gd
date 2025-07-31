extends Path2D


@export var closed: bool
@export var speedscale: float = 1
@export var active: bool

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	if active:
		activate()

func activate() -> void:
	animation_player.speed_scale = speedscale
	if closed:
		animation_player.play("move_closed")
	else:
		animation_player.play("move")
	
