extends Weapon

var target: Node2D
@export var turn_speed: float = 1.0

func _physics_process(delta):
	if attacking:
		var target_angle = (target.global_position - global_position).angle()
		rotation = rotate_toward(rotation, target_angle, turn_speed * delta)

		global_position += Vector2.RIGHT.rotated(rotation) * speed * delta
