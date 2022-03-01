extends Node2D

var lives = 30
var coins = 0
const multiple_of_coins = 5

func _ready():
	add_to_group("game_state")
	update_gui()
	
func hurt():
	$Player.hurt()
	lives -= 1
	update_gui()
	if lives < 0:
		end_game()
		
func end_game():
	get_tree().change_scene("res://Levels/GameOver.tscn")
	
func update_gui():
	get_tree().call_group("gui", "update_gui", lives, coins)
	
func add_coins():
	coins += 1
	if coins % multiple_of_coins == 0:
		lives += 1
		$ExtraLifeSfx.play()
	update_gui()
