extends Weapon



func _physics_process(_delta: float) -> void:
	pass

func apply_damage(body: Node2D, delta: float = 1.0):
	if body.has_method("get_countdown"):
		var countdown = body.get_countdown() as Countdown
		countdown.remove_time(damage * delta)
