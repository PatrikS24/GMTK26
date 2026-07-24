extends Control

@onready var start_game_button: Button = $VBoxContainer/StartGameButton
@onready var settings_button: Button = $VBoxContainer/SettingsButton
@onready var quit_button: Button = $VBoxContainer/QuitButton

@onready var player: Player = $"../../../Game/Player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game_button.pressed.connect(on_start_game)
	quit_button.pressed.connect(_quit)


func on_start_game():
	MainState.set_game_state(MainState.GameState.CUTSCENE)
	player.countdown.restart_timer()

func _quit():
	get_tree().quit()
