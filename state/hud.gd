extends Control

@onready var fps_label: Label = $FpsLabel
@onready var current_time_label: Label = $CurrentTimeLabel
@onready var time_left_label: Label = $TimeLeftLabel
@onready var wake_up_time_label: Label = $WakeUpTimeLabel


@export var player: Player



func _ready() -> void:
	wake_up_time_label.text = "Wake up at: %d" % player.get_countdown().get_wake_up_time()

func _process(_delta: float) -> void:
	time_left_label.text = "fall asleep in %d seconds" % player.get_countdown().get_time_left()
	fps_label.text = "FPS: %d" % Engine.get_frames_per_second()

	current_time_label.text = "Current time: %s" % format_time(player.get_countdown().get_current_time())
	wake_up_time_label.text = "wake up at: %s" % format_time(player.get_countdown().get_wake_up_time())

func format_time(time: float) -> String:
	return "%02d:%02d" % [int(time / 3600) % 24, int(time / 60) % 60]
