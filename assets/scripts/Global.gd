extends Node

onready var root = get_tree().get_root()
onready var current_scene = root.get_child( root.get_child_count() -1 )
onready var game_data = read_game_data()
onready var selected_chapter_id = 0
onready var selected_part_id = 0
onready var user_data = load_user_data()
#onready var save_game = write_data_to_json()

var popup_opened=false

func _ready():
	pass

	
func read_game_data():
	var file= File.new()
	file.open("res://assets/data/game_data.dat",File.READ)
	var gameStr=file.get_as_text()
	var gameJson=JSON.parse(gameStr)
	var data=gameJson.result
	file.close()
	return data
	
func load_user_data():
	var file= File.new()
	file.open("res://assets/data/user_data.dat",File.READ)
	var gameStr=file.get_as_text()
	var gameJson=JSON.parse(gameStr)
	var data=gameJson.result
	file.close()
	selected_chapter_id = data["LastChapter"]
	selected_part_id = data["ChaptersData"][selected_chapter_id]["LastPart"]
	return data

	
func save_game_data():
	var file= File.new()
	file.open("res://assets/data/user_data.dat",File.WRITE_READ)
	file.store_line(to_json(user_data))
	print("SAVED !!!")
	file.close()



func goto_scene(path):
    call_deferred("_deferred_goto_scene",path)

func _deferred_goto_scene(path):
    current_scene.free()
    var s = ResourceLoader.load(path)
    current_scene = s.instance()
    get_tree().get_root().add_child(current_scene)
    get_tree().set_current_scene( current_scene )