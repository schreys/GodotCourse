extends Control

var dinos = []
var rng = RandomNumberGenerator.new()
var start_time = 0
var random_time = 0
var random_dino = 0
var game_started = false
var dino_show_time = 500
var dino_is_shown_time = 0
var dino_visible = false
var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	dinos.append($"VBoxContainer/HBoxContainer2/0/Dino")
	dinos.append($"VBoxContainer/HBoxContainer2/1/Dino")
	dinos.append($"VBoxContainer/HBoxContainer2/2/Dino")
	dinos.append($"VBoxContainer/HBoxContainer3/0/Dino")
	dinos.append($"VBoxContainer/HBoxContainer3/1/Dino")
	dinos.append($"VBoxContainer/HBoxContainer3/2/Dino")
	dinos.append($"VBoxContainer/HBoxContainer4/0/Dino")
	dinos.append($"VBoxContainer/HBoxContainer4/1/Dino")
	dinos.append($"VBoxContainer/HBoxContainer4/2/Dino")
	
	
	hide_dinos()
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_started:
		var elapsed_time = OS.get_ticks_msec() - start_time
		if elapsed_time > random_time:
			if not dino_visible:
				show_dino()
			
			if dino_visible:
				if dino_is_shown_time + dino_show_time < OS.get_ticks_msec():
					hide_dino()

func show_dino():
	dino_is_shown_time = OS.get_ticks_msec()
	print(random_dino)
	dinos[random_dino].show()
	dino_visible = true
	
	
	
func hide_dino():
	dinos[random_dino].hide()
	dino_visible = false
	new_dino()
		
func hide_dinos():
	for dino in dinos:
		dino.hide()
	pass
	
func _on_DinoGame_resized():
#	var x = get_viewport_rect().size.x
#	var y = get_viewport_rect().size.y - 100
#
#	for dino in dinos:
#		dino.rect_min_size.x = round(x/3)
#		dino.rect_min_size.y = round(y/3)
	pass
	
func _on_Button_pressed():
	start_game()
	
func start_game():
	game_started = true
	new_dino()
	
func new_dino():
	random_time = rng.randi_range(1000, 3000)
	random_dino = rng.randi_range(0,8)
	start_time = OS.get_ticks_msec()
	
func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			var dino_rect = dinos[random_dino].get_global_rect();
		
			if dino_rect.has_point(event.position):
				points = points + 1
				$"VBoxContainer/HBoxContainer/Points".text = String(points)
	