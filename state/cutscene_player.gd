class_name CutscenePlayer extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var phone_hand: TextureRect = $CanvasLayer/HandHandle/PhoneHand

@onready var player: Player = $"../Game/Player"
@onready var canvas_layer: CanvasLayer = $CanvasLayer

var hidden_ratio: float = 1.5
var shown_ratio: float = 0.1

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	var screen_height = get_viewport_rect().size.y

	var hidden_pos = screen_height * hidden_ratio
	var middle_pos = screen_height * shown_ratio
	phone_hand.position.y = hidden_pos

func play_cutscene():
	animation_player.play("cutscene")

func go_to_ingame():
	MainState.set_game_state(MainState.GameState.IN_GAME)

func _on_visibility_changed():
	canvas_layer.visible = visible

func play_down_and_up_animation():
	var screen_height = get_viewport_rect().size.y

	# Define positions using percentages
	var hidden_pos = screen_height * hidden_ratio
	var middle_pos = screen_height * shown_ratio
	phone_hand.position.y = hidden_pos
	# Reset position immediately to hidden before running to prevent overlapping glitches
	position.y = hidden_pos

	# Create a sequential tween chain
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC)

	# Step 1: Slide UP from bottom to the middle (Smooth decelerating finish)
	tween.tween_property(phone_hand, "position:y", middle_pos, 2.0).set_ease(Tween.EASE_OUT)

	# Step 2: Hold still in the middle for 1.5 seconds
	tween.tween_interval(1.5)

	# Step 3: Slide BACK DOWN to hidden position (Snappy accelerating start)
	tween.tween_property(phone_hand, "position:y", hidden_pos, 1.5).set_ease(Tween.EASE_IN)
