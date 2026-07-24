extends Node2D

@onready var game: Node2D = $Game
@onready var main_menu: Control = $UI/CanvasLayer/MainMenu
@onready var hud: Control = $UI/CanvasLayer/HUD



func _ready() -> void:
	MainState.onCutScene.connect(on_cutscene)
	MainState.onInGame.connect(on_in_game)
	MainState.onMenu.connect(on_menu)
	MainState.set_game_state(MainState.GameState.MENU)

func on_menu():
	game.visible = false
	hud.visible = false
	main_menu.visible = true

func on_cutscene():
	game.visible = false
	hud.visible = false
	main_menu.visible = false

func on_in_game():
	game.visible = true
	hud.visible = true
	main_menu.visible = false
