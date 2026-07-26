extends Sprite2D

@export var curve: Curve


var time := 0.0
@export var speed = 1.5
@export var actual_scale: Vector2 = Vector2(0.25, 0.25)

func _physics_process(delta):
	time += delta

	# Loop 0..1
	var u := fmod(time * speed, 1.0)

	# Evaluate curve
	var wave := curve.sample(u)

	# Child node must NOT multiply previous scale
	# It must overwrite scale every frame
	scale = Vector2.ONE * wave * actual_scale
