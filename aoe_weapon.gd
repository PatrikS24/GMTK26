extends Weapon

var player_in_area: Node2D

func _physics_process(delta: float) -> void:
	if player_in_area:
		if player_in_area.has_method("get_countdown"):
			apply_damage(player_in_area, delta)



func _on_body_entered(body: Node2D) -> void:
	player_in_area = body


func _on_body_exited(_body: Node2D) -> void:
	player_in_area = null
