extends Control

@onready var volume_slider: HSlider = $VBoxContainer/VolumeSlider
@onready var back_button: Button = $VBoxContainer/BackButton

var master_bus_index: int = 0

func _ready() -> void:
	master_bus_index = AudioServer.get_bus_index("Master")
	volume_slider.value_changed.connect(_on_volume_changed)
	volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus_index))
	back_button.pressed.connect(_to_main_menu)

func _on_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		master_bus_index,
		linear_to_db(value)
	)

func _to_main_menu():
	MainState.set_game_state(MainState.GameState.MENU)
