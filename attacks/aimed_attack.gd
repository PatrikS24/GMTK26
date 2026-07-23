class_name AimedAttack extends Attack



func spawn_weapons():
	for i in range(weapons_per_attack):
		var rand_pos = manager.get_rand_spawn_pos_circle()
		var weapon = _create_weapon()
		weapon.global_position = rand_pos
		weapon.look_at(manager.get_player_pos())
		print("Spawned weapon at: ", rand_pos)
