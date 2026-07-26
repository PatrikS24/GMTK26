extends AudioStreamPlayer2D


var sounds: Array[AudioStream] = [
	preload("res://assets/sfx/hurt_sound-01.wav"),
	preload("res://assets/sfx/hurt_sound-02.wav"),
	preload("res://assets/sfx/hurt_sound-03.wav"),
	preload("res://assets/sfx/hurt_sound-04.wav"),
	preload("res://assets/sfx/hurt_sound-05.wav"),
	preload("res://assets/sfx/hurt_sound-06.wav"),
	preload("res://assets/sfx/hurt_sound-07.wav"),
]

var gulp_sound = preload("res://assets/sfx/gulp.wav")

func _ready() -> void:
	MainState.damageDealt.connect(play_hurt_sound)
	MainState.atePills.connect(play_gulp_sound)

func play_hurt_sound():
	if not is_playing():
		var sound_index: int = randi() % sounds.size()
		stream = sounds[sound_index]
		play()

func play_gulp_sound():
	stream = gulp_sound
	play()
