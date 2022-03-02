extends Node2D

const SPEED = 400

func _ready():
	set_as_toplevel(true)
	global_position = get_parent().global_position

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _process(delta):
	position.y += SPEED * delta	
	manage_collisions()

func manage_collisions():
	for body in $Area2D.get_overlapping_bodies():
		if body.name == "Player":
			get_tree().call_group("game_state", "hurt")
		queue_free()