class_name Attack extends Node


@export var manager: AttackManager
@export var weapon_type: PackedScene

@export var weapons_per_attack: int = 5



func spawn_weapons():
	push_error("choose_spawn_locations() not implemented")



func _create_weapon() -> Weapon:
	var weapon_instance = weapon_type.instantiate() as Weapon
	get_tree().root.add_child(weapon_instance)
	return weapon_instance
