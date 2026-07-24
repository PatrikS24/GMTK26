extends Control

@onready var continue_button: Button = $VBoxContainer/ContinueButton
@onready var quit_button: Button = $VBoxContainer/QuitButton

@onready var to_main_menu_button: Button = $VBoxContainer/ToMainMenuButton
@onready var restart_button: Button = $VBoxContainer/RestartButton

@onready var player: Player = $"../../../Game/Player"


func _ready() -> void:
	to_main_menu_button.pressed.connect(_to_main_menu)
	restart_button.pressed.connect(_restart)
	quit_button.pressed.connect(_quit)
	continue_button.pressed.connect(_continue)

func _to_main_menu():
	MainState.set_game_state(MainState.GameState.MENU)

func _restart():
	MainState.set_game_state(MainState.GameState.MENU)
	MainState.set_game_state(MainState.GameState.IN_GAME)
	player.countdown.restart_timer()

func _quit():
	get_tree().quit()

func _continue():
	MainState.set_game_state(MainState.GameState.IN_GAME)
