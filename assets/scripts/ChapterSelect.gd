extends Node

export (String) var next_scene = ""

var game_data = global.game_data
onready var user_data = global.user_data

var anim_is_finished=true
var chapter_num = get_chapter_number()
var img_paths = get_chapter_images()
var chapter_names = get_chapter_names()
var chapter_desc = get_chapter_desc()
var selected_index = global.selected_chapter_id
onready var nodes = [ get_node("Chapter1"),get_node("Chapter2"),get_node("Chapter3")]
var next_scene_instance = null

var is_sliding=false

func _ready():
	# Sets chapter chapter_num and images with loop
	for i in range(0,3):
		nodes[i].get_child(2).set_text(chapter_num[selected_index])
		nodes[i].get_child(0).set_texture(img_paths[selected_index])
	get_node("ChapterName").set_text(chapter_names[selected_index])
	get_node("ChapterText").set_text(chapter_desc[selected_index])
	pass
	
# 
func _input(event):
	#Animation speed will connect to event speed
	if(event is InputEventScreenDrag):
		if(event.relative.x>50):
			print("sliding")
			is_sliding=true
			_on_LeftArrow_pressed()
		if(event.relative.x<-50):
			print("sliding")
			is_sliding=true
			_on_RightArrow_pressed()

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
		call_deferred("show_exit_popup")

func _on_RightArrow_pressed():
	if(anim_is_finished):
		if selected_index != chapter_num.size() - 1 :
			nodes[2].get_child(2).set_text(chapter_num[selected_index + 1])
			nodes[1].get_child(2).set_text(chapter_num[selected_index])
			nodes[2].get_child(0).set_texture(img_paths[selected_index + 1])
			nodes[1].get_child(0).set_texture(img_paths[selected_index])
			get_node("ChapterName").set_text(chapter_names[selected_index + 1])
			get_node("ChapterText").set_text(chapter_desc[selected_index + 1])
			get_node("AnimationPlayer").play("ChapterAnimRight")
			anim_is_finished=false
			selected_index = selected_index + 1
	pass # replace with function body

func _on_LeftArrow_pressed():
	if(anim_is_finished):
		if(selected_index != 0):
			nodes[0].get_child(2).set_text(chapter_num[selected_index - 1])
			nodes[1].get_child(2).set_text(chapter_num[selected_index])
			nodes[0].get_child(0).set_texture(img_paths[selected_index -1])
			nodes[1].get_child(0).set_texture(img_paths[selected_index])
			get_node("ChapterName").set_text(chapter_names[selected_index - 1])
			get_node("ChapterText").set_text(chapter_desc[selected_index - 1])
			get_node("AnimationPlayer").play("ChapterAnimLeft")
			anim_is_finished=false
			selected_index = selected_index - 1
func _on_AnimationPlayer_animation_finished(anim_name):
	#Maybe will add a condition for anim_name
	anim_is_finished=true
	is_sliding=false
	
func get_chapter_names():
	var chapter_names = []
	for a in range(game_data.size()):
		chapter_names.append(game_data[a]["Name"])
	return chapter_names
	
func get_chapter_desc():
	var chapter_desc = []
	for a in range(game_data.size()):
		chapter_desc.append(game_data[a]["Description"])
	return chapter_desc

func get_chapter_number():
	var chapter_num = []
	for a in range(game_data.size()):
		chapter_num.append("Chapter "+str(a+1))
	return chapter_num

func get_chapter_images():
	var images = []
	for a in range(game_data.size()):
		images.append(load(game_data[a]["Image"]))
	return images
	
func _on_ChapterImage_released():
	if(!is_sliding && !global.popup_opened):
		global.selected_chapter_id = selected_index
		user_data["LastChapter"] = selected_index
		global.save_game_data()
		global.goto_scene(next_scene)

func show_exit_popup():
	var popup_res=ResourceLoader.load("res://scenes/ExitPopUp.tscn")
	var popup_instance=popup_res.instance()
	add_child(popup_instance)
