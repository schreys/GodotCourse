extends Control

var prompts = ["Wat ben ik?", "Wat ben jij?", "Wat zijn wij?"]
var story = "Ik ben de %s, jij bent de %s, en wij zijn de %s"
var player_words = []

onready var DisplayText = $VBoxContainer/DisplayText
onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText

func _ready():
	DisplayText.text = "Welcome loser ";
	update_DisplayText()
	
func _on_PlayerText_text_entered(new_text):
	add_words()
	
func add_words():
	player_words.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	update_DisplayText()

func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_words()

func update_DisplayText():
	if is_story_done():
		DisplayText.text = story % player_words
		end_game()
	else:
		DisplayText.text += prompts[player_words.size()]

func is_story_done():
	return prompts.size() == player_words.size()
	
	
func end_game():
	PlayerText.queue_free()


	