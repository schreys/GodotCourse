extends Node2D

var coints = 0
var coin_taken = false

func _on_Area2D_body_entered(body):
	if not coin_taken:
		coin_taken = true
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("die")
		get_tree().call_group("game_state", "add_coins")

func die():
	queue_free()
	
