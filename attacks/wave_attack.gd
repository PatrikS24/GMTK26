extends Attack


func spawn_weapons():
	var left = bool(randi()%2)
	var positions = manager.get_positions_on_y_axis(weapons_per_attack, 1500, left, 1000)
	for pos in positions:
		var weapon = _create_weapon() as WaveWeapon
		weapon.global_position = pos
		weapon.init_wave(left, pos, 0.0)
		if not weapon.is_node_ready():
			await weapon.ready
		weapon.create_children(weapon_type, left)
