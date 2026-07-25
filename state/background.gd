class_name BackgroundController extends CanvasLayer

@export var camera: Camera2D
@onready var background: ColorRect = $Background

@onready var eye_animation_player: AnimationPlayer = $EyeAnimationPlayer



@export var eye_openness: float = 1.0


var active_tween: Tween

func _ready() -> void:
	MainState.damageDealt.connect(open_eyes_a_little)


func _process(delta: float) -> void:
	if MainState.get_state() == MainState.GameState.IN_GAME:
		eye_openness = lerp(eye_openness, 0.0, 0.01)

	var mat := background.material as ShaderMaterial
	mat.set_shader_parameter("camera_position", camera.global_position)
	mat.set_shader_parameter("viewport_size", get_viewport().get_visible_rect().size)
	mat.set_shader_parameter("eye_openness", eye_openness)

func open_eyes_a_little():
	if active_tween and active_tween.is_valid():
		active_tween.kill()

	# 2. Create the new tween safely
	active_tween = create_tween()
	active_tween.tween_property(self, "eye_openness", eye_openness + 0.2, 0.1)

func open_eyes():
	eye_animation_player.play("open_eyes")

func close_eyes():
	eye_animation_player.play("close_eyes")
