extends Node2D

const OBSTACLE = preload("uid://dnlywqxdc0qbj")
const MARGIN: float = 100.0

@onready var spawn_timer: Timer = $SpawnTimer
@onready var upper_sp: Marker2D = $UpperSP
@onready var lower_sp: Marker2D = $LowerSP
@onready var obstacle_container: Node = $ObstacleContainer

static var vp_rect: Rect2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	update_vp_rect()
	spawn_obstacle()

func update_vp_rect() -> void:
	vp_rect = get_viewport_rect()

func spawn_obstacle() -> void:
	var new_obstacle: Obstacle = OBSTACLE.instantiate()
	new_obstacle.position.y = randf_range(upper_sp.position.y, lower_sp.position.y)
	new_obstacle.position.x = vp_rect.end.x + MARGIN
	obstacle_container.add_child(new_obstacle)

func _on_spawn_timer_timeout() -> void:
	spawn_obstacle()


func _on_plane_dead() -> void:
	get_tree().paused = true
