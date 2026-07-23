class_name AttackManager extends Node

@export var player: Node2D
@export var spawn_circle_radius: int = 600


@export var attacks: Array[Attack]

func get_rand_spawn_pos_circle(distance_from_player: int = spawn_circle_radius) -> Vector2:
	return player.global_position + Vector2.from_angle(randf() * 2 * PI).normalized() * distance_from_player

func get_spawn_pos_arc(num_of_points: int, radians: float, start_angle: float = NAN, distance_from_player: int = spawn_circle_radius):
	if is_nan(start_angle):
		start_angle = randf() * 2 * PI

	var angle_diff = radians / num_of_points

	var positions: Array[Vector2] = []
	for i in num_of_points:
		var spawn_position = player.global_position + Vector2.from_angle(start_angle + angle_diff * i).normalized() * distance_from_player
		positions.append(spawn_position)
	return positions


func get_player_pos() -> Vector2:
	return player.global_position

func _on_do_new_attack_timer_timeout() -> void:
	attacks[0].spawn_weapons()
