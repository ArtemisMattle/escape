extends Camera2D

var basePos: Vector2 = Vector2(222, -60)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.deactivate.connect(follow)

func follow(character: CharacterBody2D) -> void:
	reparent(character)
	position = basePos
