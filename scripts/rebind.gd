extends Control

@onready var act : PackedScene = preload("res://scenes/action.tscn")
@onready var actionList : VBoxContainer = $PanelContainer/CenterContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer


var isRebinding: bool = false
var RemapAction = null
var RemapButton = null
var RemapEvent	= null

var usedEvents : Array[InputEvent] = []

var inpActions: Dictionary = {
	"jump"	: "Jump",
	"up"	: "Up or Climb",
	"down"	: "Down or Drop",
	"left"	: "Left",
	"right"	: "Right",
	"use"	: "Interact",
	"special": "Special",
	"specialAimUp": "Aim Upwards",
	"specialAimDown": "Aim Downwards",
	"nextChar": "Cycle Characer",
}

func _ready() -> void:
	createActionList()

func createActionList() -> void:
	InputMap.load_from_project_settings()
	for child in actionList.get_children():
		child.queue_free()
	
	for actions in inpActions:
		var action: Control = act.instantiate()
		var lable: Label = action.find_child("action")
		var buttons: Array[Button] = [action.find_child("button1"),action.find_child("button2"),action.find_child("button3")]
		
		lable.text = inpActions[actions]
		
		var events = InputMap.action_get_events(actions)
		usedEvents.append_array(events)
		events.resize(buttons.size())
		
		for i in buttons.size():
			if events[i] != null:
				buttons[i].pressed.connect(rebind.bind(buttons[i], actions, events[i]))
				buttons[i].text = events[i].as_text().trim_suffix(" (Physical)").trim_prefix("Joypad Motion on ").left(20).trim_suffix(" (Bot").trim_suffix(" (Top").trim_suffix(" (Rig").trim_suffix(" (Lef")
			else:
				buttons[i].text = " "
				buttons[i].pressed.connect(rebind.bind(buttons[i], actions, null))
				
		actionList.add_child(action)

func rebind(button: Button, action, event) -> void:
	if !isRebinding:
		isRebinding = true
		RemapAction = action
		RemapButton = button
		RemapEvent  = event
		button.text = "Press Key to bind..."
		if event != null:
			InputMap.action_erase_event(action, event)
			usedEvents.erase(event)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		return
	if isRebinding:
		if rejectEvent(event):
			accept_event()
			return
		print(event)
		if event.as_text().trim_suffix(" (Physical)") == "Escape":
			if RemapEvent != null:
				InputMap.action_add_event(RemapAction, RemapEvent)
				RemapButton.text = RemapEvent.as_text().trim_suffix(" (Physical)").trim_prefix("Joypad Motion on ").left(20).trim_suffix(" (Bot").trim_suffix(" (Top").trim_suffix(" (Rig").trim_suffix(" (Lef")
				usedEvents.append(RemapEvent)
			else:
				RemapButton.text = " "
			
			isRebinding = false
			RemapAction = null
			RemapButton = null
			RemapEvent  = null
			accept_event()
			return
		
		if event is InputEventMouseButton && event.double_click:
			event.double_click = false
		
		InputMap.action_add_event(RemapAction, event)
		RemapButton.text = event.as_text().trim_suffix(" (Physical)").trim_prefix("Joypad Motion on ").left(20).trim_suffix(" (Bot").trim_suffix(" (Top").trim_suffix(" (Rig")
		usedEvents.append(event)
		
		RemapButton.pressed.disconnect(rebind)
		RemapButton.pressed.connect(rebind.bind(RemapButton, RemapAction, event))
		
		isRebinding = false
		RemapAction = null
		RemapButton = null
		RemapEvent	= null
		accept_event()

func rejectEvent(event: InputEvent) -> bool:
	print(usedEvents)
	print(event)
	for e in usedEvents:
		if e.is_match(event, false):
			print("test")
			return true
	return false


func _on_reset_pressed() -> void:
	usedEvents = []
	createActionList()


func _on_return_pressed() -> void:
	visible = false
