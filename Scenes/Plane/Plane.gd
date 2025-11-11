extends CharacterBody2D

class_name PlaneCharacter

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var jump: float = 360.0
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
		velocity.y = -jump
		animation_player.stop()
		animation_player.play("jump")
 
func _physics_process(delta: float) -> void:
	fly(delta)
	move_and_slide()
	if is_on_floor() or is_on_ceiling():
		die()

func fly(delta: float) -> void:
	velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump
		animation_player.stop()
		animation_player.play("jump")
	
func die() -> void:
	set_physics_process(false)
	SignalHub.on_plane_die.emit()
	animation_player.pause()
	animated_sprite_2d.stop()
	
