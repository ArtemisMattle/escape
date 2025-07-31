extends Camera2D

var basePos: Vector2 = Vector2(222, -60)

@export var currentChar: CharacterBody2D
@export var otherChar: CharacterBody2D
@export var settings: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.deactivate.connect(follow)
	follow(currentChar)

func follow(character: CharacterBody2D) -> void:
	reparent(character)
	if character != currentChar:
		var c: CharacterBody2D = currentChar
		currentChar = otherChar
		otherChar = c
	currentChar = character
	position = basePos

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("nextChar"):
		otherChar._on_activate()
	if event.is_action_pressed("escape"):
		settings.visible = true
		
