extends Area2D

@onready var animator : AnimationPlayer = $animator
@onready var collider : CollisionShape2D = $collider
@onready var timer: Timer = $Timer
@onready var hazard: PackedScene = load("res://scenes/bubble_hazard.tscn")
@onready var haz_con: Node = $hazCon

var jumpState: State

var velocity: Vector2 = Vector2(100, 0)

var minHeight: float = 100.0
var bounceVel: float = 500.0
var recoil: float = 30.0

func stateInit(jump: State) -> void:
	jumpState = jump
	visible = false

func activate() -> void:
	animator.play("idle")
	set_physics_process(true)
	collider.disabled = false
	visible = true
	timer.start()

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "berylBubblegum":
		if position.y - body.position.y > minHeight:
			body.stateMachine.currentState.nextState = jumpState
			body.velocity.y = - bounceVel
			velocity.y += recoil
			
	elif body is TileMapLayer:
		velocity = Vector2(0, 0)
		animator.play("pop")

func _physics_process(delta: float) -> void:
	position = position + velocity * delta

func deactivate() -> void:
	var haz: Node2D = hazard.instantiate()
	haz_con.add_child(haz)
	haz.global_position = global_position
	set_physics_process(false)
	visible = false
	SignalBus.enableSpecial.emit()


func _on_timer_timeout() -> void:
	SignalBus.enableSpecial.emit()
