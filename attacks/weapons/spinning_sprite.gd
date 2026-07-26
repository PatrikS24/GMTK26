extends Sprite2D

@export var spin_speed: float = PI / 4.0

func _physics_process(delta: float) -> void:
	rotate(spin_speed * delta)
