class_name AimedAttack extends Attack



func spawn_weapons():
	var positions = manager.get_spawn_pos_arc(int(weapons_per_attack/3), (0.5 * PI), 0.0)
	positions.append_array(manager.get_spawn_pos_arc(int(weapons_per_attack/3), (0.5 * PI), 2*PI/3))
	positions.append_array(manager.get_spawn_pos_arc(int(weapons_per_attack/3), (0.5 * PI), 4*PI/3))
	for pos in positions:
		var weapon = _create_weapon()
		weapon.global_position = pos
		weapon.look_at(manager.get_player_pos())
