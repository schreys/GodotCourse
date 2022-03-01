extends Area2D

func _on_Spring_body_entered(body):
	$AnimationPlayer.play("boost")
	body.boost()
