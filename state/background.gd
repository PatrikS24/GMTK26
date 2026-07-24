extends CanvasLayer

@export var camera: Camera2D
@onready var background: ColorRect = $Background


func _process(delta: float) -> void:
	var mat := background.material as ShaderMaterial
	mat.set_shader_parameter("camera_position", camera.global_position)
	mat.set_shader_parameter("viewport_size", get_viewport().get_visible_rect().size)
