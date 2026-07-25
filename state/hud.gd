class_name Hud extends Control

@onready var fps_label: Label = $FpsLabel

@onready var time_left_label: Label = $HBoxContainer/TimeLeftLabel
@onready var current_time_label: Label = $HBoxContainer/CurrentTimeLabel
@onready var wake_up_time_label: Label = $HBoxContainer/WakeUpTimeLabel


@export var player: Player



func _ready() -> void:
	wake_up_time_label.text = "Wake up at: %s" % format_time(player.get_countdown().get_wake_up_time())

func _process(_delta: float) -> void:
	time_left_label.text = "Falling asleep in %d seconds" % player.get_countdown().get_time_left()
	fps_label.text = "FPS: %d" % Engine.get_frames_per_second()

	current_time_label.text = "Current time: %s" % format_time(player.get_countdown().get_current_time())

static func format_time(time: float) -> String:
	return "%02d:%02d" % [int(time / 3600) % 24, int(time / 60) % 60]

static func format_minutes(time: float) -> String:
	return "%d" % [int(time / 60) % 60]

static func format_hours(time: float) -> String:
	return "%d" % [int(time / 3600)]
