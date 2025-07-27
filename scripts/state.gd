extends Node
class_name State

@export var canMove: bool = true

var character: CharacterBody2D
var nextState: State

func stateInput(event: InputEvent):
	pass

func onEnter():
	pass

func onExit():
	pass
