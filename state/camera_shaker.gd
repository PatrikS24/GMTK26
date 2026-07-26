extends Camera2D

@export var decay := 100.0
@export var speed := 25.0

var strength := 0.0
var noise := FastNoiseLite.new()
var time := 0.0

func _ready():
	noise.seed = randi()
	noise.frequency = 1.0
	MainState.damageDealt.connect(shake)

func _process(delta):
	time += delta * speed

	strength = move_toward(strength, 0.0, decay * delta)

	offset = Vector2(
		noise.get_noise_2d(time, 0.0),
		noise.get_noise_2d(0.0, time)
	) * strength

func shake():
	strength = max(strength, 50)
