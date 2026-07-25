extends Node

enum GameState {MENU, CUTSCENE, IN_GAME, PAUSE, GAME_OVER, SETTINGS}

var state: GameState = GameState.MENU



signal onMenu
signal onInGame
signal onCutScene
signal onPause
signal onGameOver
signal onSettings

signal damageDealt

func set_game_state(new_state: GameState):
	if new_state != GameState.IN_GAME:
		get_tree().paused = true
	else:
		get_tree().paused = false
	match new_state:
		GameState.MENU:
			state = GameState.MENU
			onMenu.emit()
		GameState.CUTSCENE:
			state = GameState.CUTSCENE
			onCutScene.emit()
		GameState.IN_GAME:
			state = GameState.IN_GAME
			onInGame.emit()
		GameState.PAUSE:
			state = GameState.PAUSE
			onPause.emit()
		GameState.GAME_OVER:
			state = GameState.GAME_OVER
			onGameOver.emit()
		GameState.SETTINGS:
			state = GameState.SETTINGS
			onSettings.emit()

func get_state():
	return state

func onDamageDealt():
	damageDealt.emit()
