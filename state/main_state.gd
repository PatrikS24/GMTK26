extends Node

enum GameState {MENU, CUTSCENE, IN_GAME}

var state: GameState = GameState.MENU

signal onMenu
signal onInGame
signal onCutScene

func set_game_state(new_state: GameState):
	match new_state:
		GameState.MENU:
			_to_menu()
		GameState.CUTSCENE:
			_to_cut_scene()
		GameState.IN_GAME:
			_to_in_game()

func get_state():
	return state

func _to_cut_scene():
	state = GameState.CUTSCENE
	onCutScene.emit()

func _to_in_game():
	state = GameState.IN_GAME
	onInGame.emit()

func _to_menu():
	state = GameState.MENU
	onMenu.emit()
