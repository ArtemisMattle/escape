extends Label

@export var StateMachine: StateMachine


func _process(_delta: float) -> void:
	text = "State: " + StateMachine.currentState.name
