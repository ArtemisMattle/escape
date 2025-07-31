extends Node2D


func _on_damage_area_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		SignalBus.takeDamage.emit(body)
