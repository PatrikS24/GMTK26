extends Attack



func spawn_weapons():
	var positions = manager.get_spawn_pos_arc(weapons_per_attack, 2 * PI, 0.0, 1200)
	for pos in positions:
		var weapon = _create_weapon()
		weapon.global_position = pos
		weapon.look_at(manager.get_player_pos())
		weapon.target = manager.player
