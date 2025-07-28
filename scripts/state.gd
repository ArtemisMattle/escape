extends Node
class_name State

@export var canMove: bool = true
@export var canSpecial: bool = true

var character: CharacterBody2D
var nextState: State

func stateInit() -> void:
	pass

func onEnter() -> void:
	pass

func stateInput(event: InputEvent) -> void:
	pass

func stateProcess(delta: float) -> void:
	pass

func onExit() -> void:
	pass
