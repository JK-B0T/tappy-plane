extends Node

const GAME = preload("uid://xfhspw51npnf")
const MAIN = preload("uid://c1qrpc1gc1kpb")
const GAME_OVER_SOUND = preload("uid://rcxwfof8x1sn")
const LOADING_SCREEN = preload("uid://6qw5g6dar5nn")

const SCORE_PATH = "user://player_data.tres"

var next_screen: PackedScene

var _high_score: int = 0
var high_score: int:
	get:
		return _high_score
	set(new_score):
		if new_score > _high_score:
			_high_score = new_score

func load_game_scene() -> void:
	next_screen = GAME
	get_tree().change_scene_to_packed(LOADING_SCREEN)

func load_main_scene() -> void:
	next_screen = MAIN
	get_tree().change_scene_to_packed(LOADING_SCREEN)
	
func load_player_highscore() -> void:
	if ResourceLoader.exists(SCORE_PATH):
		var player_highscore: PlayerDataResource = load(SCORE_PATH)
		if player_highscore:
			_high_score = player_highscore.player_highscore

func save_player_highscore() -> void:
	var player_highscore: PlayerDataResource = PlayerDataResource.new()
	player_highscore.player_highscore = _high_score
	ResourceSaver.save(player_highscore, SCORE_PATH)
