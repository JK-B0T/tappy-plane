extends Control

@onready var highscore: Label = $MarginContainer/Highscore

func _ready() -> void:
	GameManager.load_player_highscore()
	highscore.text = "%04d" % GameManager.high_score

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump", false):
		get_viewport().set_input_as_handled()
		GameManager.load_game_scene()
