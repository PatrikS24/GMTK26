extends Node

@onready var game: Node2D = $Game
@onready var main_menu: Control = $UI/CanvasLayer/MainMenu
@onready var hud: Control = $UI/CanvasLayer/HUD
@onready var cutscene: CutscenePlayer = $Cutscene

@export var attack_manager: AttackManager

func _ready() -> void:
	MainState.onCutScene.connect(on_cutscene)
	MainState.onInGame.connect(on_in_game)
	MainState.onMenu.connect(on_menu)
	MainState.set_game_state(MainState.GameState.MENU)

func on_menu():
	game.visible = false
	hud.visible = false
	main_menu.visible = true
	cutscene.visible = false

func on_cutscene():
	game.visible = false
	hud.visible = false
	main_menu.visible = false
	cutscene.visible = true
	cutscene.play_cutscene()

func on_in_game():
	game.visible = true
	hud.visible = true
	main_menu.visible = false
	cutscene.visible = false
	attack_manager.start_spawning()
