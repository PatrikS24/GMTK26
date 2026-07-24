class_name WaveWeapon extends Weapon

@export var num_of_children := 10

var time := 0.0
var amplitude = 200.0

var frequency := 2.0
var phase = 0.0
var phase_offset = 0.1

var direction: Vector2
var start_pos: Vector2


func _physics_process(delta):
	if attacking:
		time += delta

		var forward = direction * speed * time
		var sideways = direction.orthogonal() * sin(time * frequency + phase) * amplitude

		global_position = start_pos + forward + sideways


func init_wave(left: bool, start_position: Vector2, offset: float):
	direction = Vector2.LEFT if !left else Vector2.RIGHT
	start_pos = start_position
	phase = offset

func create_children(scene: PackedScene, left: bool):
	var dir = Vector2.LEFT if left else Vector2.RIGHT
	for i in range(num_of_children):
		var new_weapon := scene.instantiate() as WaveWeapon
		new_weapon.global_position = start_pos + dir * 150 * (1+i)
		get_tree().root.add_child(new_weapon)

		new_weapon.init_wave(left, new_weapon.global_position, -(i + 1) * phase_offset)
