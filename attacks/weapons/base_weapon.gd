class_name Weapon extends Area2D

@export var speed: float = 50.0
var attacking: bool = false


func _physics_process(delta: float) -> void:
	if attacking:
		global_position += transform.x * speed * delta

func start_attack():
	attacking = true

func destroy():
	queue_free()
