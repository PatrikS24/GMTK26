class_name CutscenePlayer extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var player: Player = $"../Game/Player"


func play_cutscene():
	animation_player.play("cutscene")

func go_to_ingame():
	MainState.set_game_state(MainState.GameState.IN_GAME)
