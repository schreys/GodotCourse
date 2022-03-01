extends CanvasLayer

func update_gui(lives: int, coins: int):
	$Control/TextureRect/HBoxContainer/Score.text = str(lives)
	$Control/TextureRect/HBoxContainer/Coins.text = str(coins)
