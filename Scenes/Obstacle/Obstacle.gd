extends Node2D

class_name Obstacle

@export var speed: float = 120.0
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= speed * delta


func _on_2d_screen_exited() -> void:
	set_process(false)
	queue_free()


func _on_pipe_body_entered(body: Node2D) -> void:
	if body is PlaneCharacter:
		body.die()
