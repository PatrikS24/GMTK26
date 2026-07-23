class_name Countdown extends Node

@onready var timer: Timer = $Timer

func add_time(time: float):
	var remaining = timer.time_left
	remaining += time
	timer.start(remaining)

func remove_time(time: float):
	var remaining = timer.time_left
	remaining -= time
	timer.start(remaining)

func get_time_left():
	return timer.time_left

func death():
	pass # TODO

func _on_timer_timeout() -> void:
	death()
