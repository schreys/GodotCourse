extends Area2D

func _on_Spiketop_body_entered(body):
	get_tree().call_group("game_state", "hurt")
	
