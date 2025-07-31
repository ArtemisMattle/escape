extends Button




func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
