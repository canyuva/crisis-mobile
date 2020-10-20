extends Control

onready var user_data = global.user_data

export (String) var next_scene_path = ""
func _ready():
	global.goto_scene(next_scene_path)
	pass

