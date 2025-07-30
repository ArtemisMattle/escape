extends Label

@export var Machine: StateMachine


func _process(_delta: float) -> void:
	text = "State: " + Machine.currentState.name
