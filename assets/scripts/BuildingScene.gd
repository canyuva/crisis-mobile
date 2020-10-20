extends Control

onready var game_data = global.game_data
onready var user_data = global.user_data
onready var building_index
onready var building = game_data[global.selected_chapter_id]["Partitions"][global.selected_part_id]["Buildings"][building_index]
var user_option = null
var is_game_load = false

func _ready():
	user_option = user_data["ChaptersData"][global.selected_chapter_id]["Parts"][global.selected_part_id]["Buildings"][building_index]["SelectedOption"]
	get_node("AnimationPlayer").play("popup_anim")
	get_building_props()
	
	if(user_option != null):
		load_game()
		is_game_load = true
	else:
		get_building_options()

func load_game():
	get_node("Background/SelectedOption/SelectedOptionText").set_text(building["Options"][user_option]["Text"])


func _on_ExitButton_released():
	queue_free()

func get_building_props():
	get_node("Background/BuildingText").set_text(building["Name"])
	get_node("Background/BuildingDescription").set_text(building["Message"])
	get_node("Background/BuildingImage").set_texture(load(building["Image"]))

func get_building_options():
	get_node("Background/Option1/Option1Label").set_text(building["Options"][0]["Text"])
	get_node("Background/Option2/Option2Label").set_text(building["Options"][1]["Text"])
	
	
func _exit_tree():
	global.popup_opened = false

func show_hide_option():
	get_node("Background/Option1").hide()
	get_node("Background/Option2").hide()
	get_node("Background/SelectedOption").show()
	get_node("Background/OptionInfo").show()
	get_node("Background/SelectedOption/SelectedOptionText").show()

func _on_Option_released(option_index):
	show_hide_option()
	var selected_option=building["Options"][option_index]
	get_node("Background/SelectedOption/SelectedOptionText").set_text(selected_option["Text"])
	user_data["ChaptersData"][global.selected_chapter_id]["Parts"][global.selected_part_id]["Buildings"][building_index]["SelectedOption"] = option_index
	#For now just add Effect value to the crisis bar, later may be we create a mathematical function for it
	var current_bar_percent=state.get_bar_percent() + selected_option["Effect"]
	var status = state.set_bar_percent(current_bar_percent)
	if(status in [state.CHAPTER_STATUS.FAIL,state.CHAPTER_STATUS.SUCCESS]):
		get_parent().done(status)
	global.save_game_data()
	if(check_all_buildings()):
		go_to_next_part()

func check_all_buildings():
	var building_dic = user_data["ChaptersData"][global.selected_chapter_id]["Parts"][global.selected_part_id]["Buildings"]
	print(building_dic.size())
	for a in range(building_dic.size()):
		print(building_dic[a])
		if(building_dic[a]["SelectedOption"] == null):
			return false
	return true

func go_to_next_part():
	if(global.selected_part_id + 1 >= game_data[global.selected_chapter_id]["Partitions"].size()):
		user_data["ChaptersData"][global.selected_chapter_id]["IsDone"]=true
		global.save_game_data()
		global.goto_scene("res://scenes/ChapterSelect.tscn")
		print("Next chapter")
	else:
		global.selected_part_id = global.selected_part_id + 1
		user_data["ChaptersData"][global.selected_chapter_id]["LastPart"] = user_data["ChaptersData"][global.selected_chapter_id]["LastPart"] + 1
		global.save_game_data()
		global.goto_scene("res://scenes/MapScene.tscn")
		print("Next part")
		
func _on_AnimationPlayer_animation_finished(anim_name):
	if(is_game_load):
		show_hide_option()
	pass # replace with function body
