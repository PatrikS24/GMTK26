extends Label

@export var player: Player

func _process(delta: float) -> void:
	text = "fall asleep in %d seconds" % player.get_countdown().get_time_left()
