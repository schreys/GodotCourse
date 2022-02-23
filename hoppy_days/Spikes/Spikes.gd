extends Area2D

func _on_Spiketop_body_entered(body):
	body.hurt()