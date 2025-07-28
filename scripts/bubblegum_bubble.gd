extends Area2D

@onready var animator : AnimationPlayer = $animator

func activate() -> void:
	animator.play("idle")
	print("s")
	visible = true
	

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		pass
	elif body is TileMapLayer:
		animator.play("pop")
