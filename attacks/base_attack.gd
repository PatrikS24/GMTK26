class_name Attack extends Node


@export var manager: AttackManager
@export var weapon_type: PackedScene

@onready var life_time_timer: Timer = $LifeTimeTimer
@onready var start_attack_timer: Timer = $StartAttackTimer

@export var weapons_per_attack: int = 5

var weapons: Array[Weapon]

func spawn_weapons():
	push_error("choose_spawn_locations() not implemented")


func _on_start_attack_timer_timeout() -> void:
	spawn_weapons()

func _create_weapon() -> Weapon:
	var weapon_instance = weapon_type.instantiate()
	get_tree().root.add_child(weapon_instance)
	return weapon_instance
