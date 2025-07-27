extends Node
class_name State

@export var canMove: bool = true

var character: CharacterBody2D
var nextState: State

func onEnter() -> void:
	pass

func stateInput(event: InputEvent) -> void:
	pass

func stateProcess(delta: float) -> void:
	pass

func onExit() -> void:
	pass
