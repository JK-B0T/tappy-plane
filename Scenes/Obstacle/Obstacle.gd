extends Node2D

class_name Obstacle

@onready var laser: Area2D = $Laser

@export var speed: float = 120.0


func _process(delta: float) -> void:
	position.x -= speed * delta


func _on_2d_screen_exited() -> void:
	set_process(false)
	queue_free()

func _on_pipe_body_entered(body: Node2D) -> void:
	if body is PlaneCharacter:
		body.die()

func _on_laser_body_entered(body: Node2D) -> void:
	if body is PlaneCharacter:
		laser.body_entered.disconnect(_on_laser_body_entered)
		SignalHub.on_score_point.emit()
