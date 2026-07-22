extends Node2D

@export var target: CharacterBody2D

@export var stiffness: float = 12.0
@export var damping: float = 6.0
@export var max_speed: float = 250.0
@export var max_distance: float = 300

var velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	var offset = target.position - position

	var distance = offset.length()
	var force = offset * stiffness

	if distance > max_distance:
		force *= 1.0 + (distance - max_distance) / max_distance

	force -= velocity * damping
	velocity += force * delta
	position += velocity * delta
