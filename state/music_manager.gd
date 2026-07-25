class_name MusicManager extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer

enum Song {MAIN_MENU, IN_GAME}

var playlist: Array[AudioStream] = [
	preload("res://assets/music/menu_music.wav"),
	preload("res://assets/music/in_game_music1.wav")
]

var current_song_index: int = -1

func play_song(song: Song):
	if current_song_index != song:
		music_player.stream = playlist[song]
		music_player.play()
		current_song_index = song
