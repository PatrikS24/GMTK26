extends Node

@onready var game: Node2D = $Game
@onready var main_menu: Control = $UI/CanvasLayer/MainMenu
@onready var hud: Control = $UI/CanvasLayer/HUD
@onready var cutscene: CutscenePlayer = $Cutscene
@onready var pause_menu: Control = $UI/CanvasLayer/PauseMenu

@export var attack_manager: AttackManager



func _ready() -> void:
	MainState.onCutScene.connect(on_cutscene)
	MainState.onInGame.connect(on_in_game)
	MainState.onMenu.connect(on_menu)
	MainState.onPause.connect(on_pause)
	MainState.set_game_state(MainState.GameState.MENU)

func _process(delta: float) -> void:
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
	attack_manager.stop_spawning()

func on_cutscene():
	game.visible = false
	hud.visible = false
	main_menu.visible = false
	cutscene.visible = true
	pause_menu.visible = false
	cutscene.play_cutscene()

func on_in_game():
	game.visible = true
	hud.visible = true
	main_menu.visible = false
	cutscene.visible = false
	pause_menu.visible = false
	attack_manager.start_spawning()


func on_pause():
	game.visible = false
	hud.visible = false
	main_menu.visible = false
	cutscene.visible = false
	pause_menu.visible = true
	attack_manager.stop_spawning()
