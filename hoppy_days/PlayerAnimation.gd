extends AnimatedSprite

func _on_Player_animate(motion: Vector2, is_hurt: bool):
	if is_hurt :
		play("hurt")
	elif(motion.y < 0):
		play("jump")			
	elif(motion.x != 0):
		play("walk")
		flip_h = motion.x < 0
	else:
		play("idle")
