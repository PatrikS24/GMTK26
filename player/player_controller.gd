class_name Player extends CharacterBody2D

@export var acceleration: float = 0.15
@export var top_speed: float = 400.0
var current_velocity: Vector2 = Vector2(0.0, 0.0)

@onready var countdown: Countdown = $Countdown

func get_countdown() -> Countdown:
	return countdown

func _physics_process(_delta: float) -> void:
	var input_vector := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()

	var new_velocity = current_velocity.lerp(input_vector * top_speed, acceleration)
	current_velocity = new_velocity
	velocity = current_velocity

	move_and_slide()
