extends Attack


func spawn_weapons():
	var min_distance = 450
	var distance = 2500
	var weapons: Array[Weapon] = []
	for i in range(weapons_per_attack):
		var weapon = _create_weapon()
		var rand_spawn_pos = manager.player.global_position + Vector2.from_angle(randf() * 2 * PI) * randi_range(min_distance, distance)
		weapon.global_position = rand_spawn_pos
		var valid := true
		for aoe in weapons:
			if (weapon.global_position - aoe.global_position).length() < 120.0:
				weapon.queue_free()
				valid = false
		if valid: weapons.append(weapon)
