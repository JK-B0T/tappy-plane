extends Control

@onready var hit_sound: AudioStreamPlayer = $HitSound
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var game_over_label: Label = $MarginContainer/GameOverLabel
@onready var press_space_label: Label = $MarginContainer/PressSpaceLabel
@onready var reset_timer: Timer = $ResetTimer

var _score: int = 0

func _enter_tree() -> void:
	SignalHub.on_plane_die.connect(plane_died)
	SignalHub.on_score_point.connect(on_score)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit", false):
		get_viewport().set_input_as_handled()
		reset()
	if event.is_action_pressed("jump", false) and press_space_label.is_visible_in_tree():
		get_viewport().set_input_as_handled()
		reset()

func reset() -> void:
	get_tree().paused = false
	reset_timer.stop()
	GameManager.load_main_scene()

func plane_died() -> void:
	game_over_label.show()
	reset_timer.start()
	GameManager.high_score = int(score_label.text) 
	GameManager.save_player_highscore()
	hit_sound.stop()
	hit_sound.stream = GameManager.GAME_OVER_SOUND
	hit_sound.play()

func on_score() -> void:
	hit_sound.play()
	_score += 1
	score_label.text = "%04d" % _score
	

func _on_reset_timer_timeout() -> void:
	game_over_label.hide()
	press_space_label.show()
