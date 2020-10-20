extends Control

export (String) var next_scene_path = ""

onready var user_data = global.user_data
onready var last_chapter_id = user_data["LastChapter"]
onready var is_done = user_data["ChaptersData"][last_chapter_id]["IsDone"]

func _ready():
	if(!is_done):
		get_node("Background/ResumeButton").set_visible(true);
	pass


func _on_PlayButton_released():
	if(is_done):
		global.goto_scene(next_scene_path)
	else:
		next_scene_path = "res://scenes/MapScene.tscn"
		global.goto_scene(next_scene_path)
	pass # replace with function body
