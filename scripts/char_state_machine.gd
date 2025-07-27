extends Node
class_name StateMachine

var character: CharacterBody2D
var States: Array[State]
@export var currentState: State

func _ready() -> void:
	var parent = get_parent()
	if parent is CharacterBody2D:
		character = parent
	else:
		push_error("Parent " + parent.name + " is not a valid Character")
	for child in get_children():
		if (child is State):
			States.append(child)
		else:
			push_warning("Child " + child.name + " is not a valid State for charStateMachine for " + get_parent().name)

func _input(event: InputEvent) -> void:
	currentState.stateInput(event)

func _process(delta: float) -> void:
	if currentState.nextState != null:
		switchState(currentState.nextState)

func switchState(nextState : State) -> void:
	if currentState != null:
		currentState.onExit()
		currentState.nextState = null
	
	currentState = nextState
	
	currentState.onEnter()
