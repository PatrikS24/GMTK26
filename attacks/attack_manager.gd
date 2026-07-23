class_name AttackManager extends Node

@export var player: Node2D
@export var spawn_circle_radius: int = 400


@export var attacks: Array[Attack]

func get_rand_spawn_pos_circle(distance_from_player: int = spawn_circle_radius) -> Vector2:
	return player.global_position + Vector2.from_angle(randf() * 2 * PI).normalized() * spawn_circle_radius


func get_player_pos() -> Vector2:
	return player.global_position

func _on_do_new_attack_timer_timeout() -> void:
	attacks[0].spawn_weapons()
