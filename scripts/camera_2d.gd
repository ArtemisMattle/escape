extends Camera2D

var basePos: Vector2 = Vector2(222, -60)

var characters: Array[CharacterBody2D] = []
var currentChar: CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.deactivate.connect(follow)
	SignalBus.checkInCharacter.connect(populate)

func follow(character: CharacterBody2D) -> void:
	reparent(character)
	currentChar = character
	position = basePos

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("nextChar"):
		if currentChar == null:
			follow(characters.pick_random())
		else:
			for c in characters:
				if c != currentChar:
					follow(c)

func populate(character: CharacterBody2D) -> void:
	if characters.has(character):
		return
	characters.append(character)
