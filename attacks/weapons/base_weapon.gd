class_name Weapon extends Area2D

@export var speed: float = 150.0
@export var damage: float = 5.0
var attacking: bool = false


func _physics_process(delta: float) -> void:
	if attacking:
		global_position += transform.x * speed * delta

func start_attack():
	attacking = true

func destroy():
	queue_free()

func apply_damage(body: Node2D):
	if body.has_method("get_countdown"):
		var countdown = body.get_countdown() as Countdown
		countdown.add_time(damage)


func _on_body_entered(body: Node2D) -> void:
	apply_damage(body)
	destroy()
