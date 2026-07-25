extends Node

@onready var game: Node2D = $Game
@onready var main_menu: Control = $UI/CanvasLayer/MainMenu
@onready var hud: Control = $UI/CanvasLayer/HUD
@onready var cutscene: CutscenePlayer = $Cutscene
@onready var pause_menu: Control = $UI/CanvasLayer/PauseMenu
@onready var game_over_screen: GameOverScreen = $UI/CanvasLayer/GameOverScreen



@export var attack_manager: AttackManager

@onready var background_controller: BackgroundController = $BackgroundController




func _ready() -> void:
	MainState.onCutScene.connect(on_cutscene)
	MainState.onInGame.connect(on_in_game)
	MainState.onMenu.connect(on_menu)
	MainState.onPause.connect(on_pause)
	MainState.onGameOver.connect(on_game_over)
	MainState.set_game_state(MainState.GameState.MENU)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if MainState.get_state() == MainState.GameState.IN_GAME:
			MainState.set_game_state(MainState.GameState.PAUSE)
		elif MainState.get_state() == MainState.GameState.PAUSE:
			MainState.set_game_state(MainState.GameState.IN_GAME)

func on_menu():
	game.visible = false
	hud.visible = false
	main_menu.visible = true
	cutscene.visible = false
	pause_menu.visible = false
	game_over_screen.visible = false
	attack_manager.stop_spawning()

func on_cutscene():
	game.visible = false
	hud.visible = false
	main_menu.visible = false
	cutscene.visible = true
	pause_menu.visible = false
	game_over_screen.visible = false

	cutscene.play_cutscene()

func on_in_game():
	game.visible = true
	hud.visible = true
	main_menu.visible = false
	cutscene.visible = false
	pause_menu.visible = false
	game_over_screen.visible = false

	attack_manager.start_spawning()
	if background_controller.eye_openness > 0.1:
		background_controller.close_eyes()

func on_pause():
	game.visible = false
	hud.visible = false
	main_menu.visible = false
	cutscene.visible = false
	pause_menu.visible = true
	game_over_screen.visible = false

	attack_manager.stop_spawning()
	background_controller.open_eyes()

func on_game_over():
	game.visible = false
	hud.visible = false
	main_menu.visible = false
	cutscene.visible = false
	pause_menu.visible = false
	game_over_screen.visible = true
	game_over_screen.update_result()
	attack_manager.stop_spawning()
	background_controller.open_eyes()
