extends Node2D

func _ready():
	$BGM.stream = load("res://SFX/Chiptune_Adventures_1.ogg")
	$BGM.play()