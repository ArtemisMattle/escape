extends Path2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func activate() -> void:
	animation_player.play("open")
	
