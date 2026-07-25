class_name Countdown extends Node

@onready var timer: Timer = $Timer

@export var countdown_time: float = 60.0

const timescale: float = 140.0
const wakeup_time : float = 60.0 * 3 * timescale

var current_time: float = 0.0

func _process(delta: float) -> void:
	if MainState.state != MainState.GameState.IN_GAME:
		timer.paused = true
	else:
		timer.paused = false
		current_time += delta * timescale
	if current_time >= wakeup_time:
		pass # TODO: game over

func add_time(time: float):
	var remaining = timer.time_left
	remaining += time
	timer.start(remaining)
	MainState.onDamageDealt()

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

func get_wake_up_time():
	return wakeup_time

func get_current_time():
	return current_time

func win():
	pass # TODO

func _on_timer_timeout() -> void:
	win()
