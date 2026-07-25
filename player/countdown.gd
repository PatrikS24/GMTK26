class_name Countdown extends Node

@onready var timer: Timer = $Timer

@export var countdown_time: float = 60.0

const wakeup_time : float = 60.0 * 3

func _process(_delta: float) -> void:
	if MainState.state != MainState.GameState.IN_GAME:
		timer.paused = true
	else: timer.paused = false

func add_time(time: float):
	var remaining = timer.time_left
	remaining += time
	timer.start(remaining)

func remove_time(time: float):
	var remaining = timer.time_left
	remaining -= time
	timer.start(remaining)

func restart_timer():
	if timer.paused == true:
		timer.paused = false
		timer.start(countdown_time)
		timer.paused = true
	else:
		timer.start(countdown_time)


func get_time_left():
	return timer.time_left

func death():
	pass # TODO

func _on_timer_timeout() -> void:
	death()
