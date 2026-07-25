extends CanvasLayer

@export var camera: Camera2D
@onready var background: ColorRect = $Background

var eye_openness: float = 1.0

func _process(delta: float) -> void:
	var mat := background.material as ShaderMaterial
	mat.set_shader_parameter("camera_position", camera.global_position)
	mat.set_shader_parameter("viewport_size", get_viewport().get_visible_rect().size)
	mat.set_shader_parameter("eye_openness", eye_openness)

	if Input.is_action_just_pressed("ui_down"):
		eye_openness -= 0.1
	if Input.is_action_just_pressed("ui_up"):
		eye_openness += 0.1
	print(eye_openness)
