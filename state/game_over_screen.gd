class_name GameOverScreen extends Control

@export var player: Player
@onready var game_status_label: Label = $VBoxContainer/GameStatusLabel
@onready var hrs_of_sleep_label: Label = $VBoxContainer/HrsOfSleepLabel
@onready var play_again_button: Button = $VBoxContainer/PlayAgainButton
@onready var main_menu_button: Button = $VBoxContainer/MainMenuButton
@onready var quit_button: Button = $VBoxContainer/QuitButton

func _ready() -> void:
	play_again_button.pressed.connect(_restart)
	main_menu_button.pressed.connect(_to_main_menu)
	quit_button.pressed.connect(_quit)

func update_result():
	game_status_label.text = "You WIN!" if player.get_countdown().win_state == Countdown.WinState.WIN else "You Lose!"
	var hrs_of_sleep = player.get_countdown().get_wake_up_time() - player.get_countdown().get_current_time()
	hrs_of_sleep_label.text = "You got slept %s hours and %s minutes" % [Hud.format_hours(hrs_of_sleep), Hud.format_minutes(hrs_of_sleep)]

func _to_main_menu():
	MainState.set_game_state(MainState.GameState.MENU)

func _restart():
	MainState.set_game_state(MainState.GameState.MENU)
	MainState.set_game_state(MainState.GameState.IN_GAME)
	player.countdown.restart_timer()

func _quit():
	get_tree().quit()
