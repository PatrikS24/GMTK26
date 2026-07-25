extends Attack


func spawn_weapons():
	var distance = 1000

	var x = bool(randi()%2)
	var y = bool(randi()%2)
	#var positions = manager.get_positions_on_x_axis(2, 1500, left, 900) if x else manager.get_positions_on_y_axis(2, 1500, left, 900)
	var positions = [
		Vector2(manager.player.global_position.x, manager.player.global_position.y - distance * (1 - (2*int(y)))),
		Vector2(manager.player.global_position.x - distance * (1 - (2*int(x))), manager.player.global_position.y),
	]
	# Laser 1 - aim straight at the player
	var weapon = _create_weapon() as Weapon
	weapon.global_position = positions[0]
	weapon.look_at(manager.player.global_position)
	# Laser 2 - same spawn point, perpendicular to laser 1
	var weapon2 = _create_weapon() as Weapon
	weapon2.global_position = positions[1]
	weapon2.look_at(manager.player.global_position)
