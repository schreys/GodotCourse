extends Control

var player_words = []

#var template = [{
#			"prompts": ["a name", "a name"],
#			"story": "story 1 %s %s"
#		},
#		{
#			"prompts": ["a name", "a name"],
#			"story": "story 2 %s %s"
#		},
#		{
#			"prompts": ["a name", "a name"],
#			"story": "story 3 %s %s"
#		},
#		{
#			"prompts": ["a name", "a name"],
#			"story": "story 4 %s %s"
#		}]
var current_story = {}

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/Label
onready var LabelButton = $VBoxContainer/HBoxContainer/LabelButton

func _ready():
	set_current_story()
	DisplayText.text = "Welcome"
	check_player_words_length()
	PlayerText.grab_focus()

func set_current_story():
	randomize()
	var stories = get_from_json("stories.json")
	current_story = stories[randi() % stories.size()]
#	var stories = $StoryBook.get_child_count()
#	var selectedStory = randi() % stories
#	current_story.prompts = $StoryBook.get_child(selectedStory).prompts
#	current_story.story = $StoryBook.get_child(selectedStory).story

func _on_PlayerText_text_entered(new_text):
	add_to_player_words()
	
func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_player_words()
	
func get_from_json(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data

func add_to_player_words():
	DisplayText.text = ""
	player_words.append(PlayerText.text)
	PlayerText.clear()
	check_player_words_length()
	
func is_story_done():
	return player_words.size() == current_story.prompts.size()
	
func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()
		
func tell_story():
	DisplayText.text = current_story.story % player_words
	
func prompt_player():
	DisplayText.text += "May I have " + current_story.prompts[player_words.size()] + " please?"
	
func end_game():
	LabelButton.text = "Again"
	tell_story()
	PlayerText.queue_free()
	
	
	