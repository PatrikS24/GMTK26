class_name AttackManager extends Node

@export var player: Node2D
@export var spawn_circle_radius: int = 700
@export var attacks: Array[Attack]

@onready var do_new_attack_timer: Timer = $DoNewAttackTimer

var last_attack: int = -1

func start_spawning():
	if do_new_attack_timer.paused == true:
		do_new_attack_timer.paused = false

	if do_new_attack_timer.is_stopped():
		do_new_attack_timer.start()
		_on_do_new_attack_timer_timeout()


func stop_spawning():
	do_new_attack_timer.paused = true

func _on_do_new_attack_timer_timeout() -> void:
	if MainState.state != MainState.GameState.IN_GAME:
		do_new_attack_timer.stop()
		return
	var index = randi() % attacks.size()
	if last_attack == -1:
		index = 1
	else:
		if index == last_attack:
			index = (index + 1) % attacks.size()
	last_attack = index
	attacks[index].spawn_weapons()


func get_rand_spawn_pos_circle(distance_from_player: int = spawn_circle_radius) -> Vector2:
	return player.global_position + Vector2.from_angle(randf() * 2 * PI).normalized() * distance_from_player

func get_spawn_pos_arc(num_of_points: int, radians: float, start_angle: float = NAN, distance_from_player: int = spawn_circle_radius) -> Array[Vector2]:
	if is_nan(start_angle):
		start_angle = randf() * 2 * PI

	var angle_diff = radians / num_of_points

	var positions: Array[Vector2] = []
	for i in num_of_points:
		var spawn_position = player.global_position + Vector2.from_angle(start_angle + angle_diff * i).normalized() * distance_from_player
		positions.append(spawn_position)
	return positions

func get_positions_on_y_axis(num_of_points: int, height: int, left_side: bool, distance_from_player: int = spawn_circle_radius) -> Array[Vector2]:
	var dir_sign = -1 if left_side else 1
	var x_pos = player.global_position.x + distance_from_player * dir_sign
	var positions: Array[Vector2] = []
	var bottom_y = player.global_position.y + height / 2.0
	var spacing = height / float(num_of_points - 1)
	for i in range(num_of_points):
		positions.append(Vector2(
			x_pos,
			bottom_y - spacing * i
		))
	return positions

func get_positions_on_x_axis(num_of_points: int, width: int, up: bool, distance_from_player: int = spawn_circle_radius) -> Array[Vector2]:
	var dir_sign = -1 if up else 1
	var y_pos = player.global_position.y + distance_from_player * dir_sign
	var positions: Array[Vector2] = []
	var left_x = player.global_position.x + width / 2.0
	var width_diff = width / float(num_of_points)
	for i in range(num_of_points):
		positions.append(Vector2(left_x - width_diff * i, y_pos))
	return positions


func get_player_pos() -> Vector2:
	return player.global_position
