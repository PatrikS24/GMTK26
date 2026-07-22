extends Node2D

@export var target: Node2D

@export var stiffness: float = 12.0
@export var damping: float = 6.0
@export var max_speed: float = 250.0

var velocity := Vector2.ZERO

func _process(delta: float) -> void:
	var offset = target.position - position

	var force = offset * stiffness
	force -= velocity * damping
	velocity += force * delta
	velocity = velocity.limit_length(max_speed)

	position += velocity * delta
