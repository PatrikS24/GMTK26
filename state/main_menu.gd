extends Control

@onready var start_game_button: Button = $VBoxContainer/StartGameButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game_button.pressed.connect(on_start_game)


func on_start_game():
	MainState.set_game_state(MainState.GameState.CUTSCENE)
