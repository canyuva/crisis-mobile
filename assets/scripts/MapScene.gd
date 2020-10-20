extends Control

onready var game_data = global.game_data
onready var user_data = global.user_data
onready var building_count = get_building_count()
onready var crisis_bar_state = state.crisis_bar
onready var selected_chapter_id=user_data["LastChapter"]
onready var selected_part_id=user_data["ChaptersData"][selected_chapter_id]["LastPart"]


func _ready():	
	load_crisis_bar()
	state.update_bar_percent()
	get_node("Background/Label").set_text("Chapter"+str(selected_chapter_id)+" - Part"+str(selected_part_id))
	show_buildings()
	pass
	
func load_crisis_bar():
	var crisis_bar_load = ResourceLoader.load("res://scenes/CrisisBar.tscn")
	crisis_bar_state['instance'] = crisis_bar_load.instance()
	add_child(crisis_bar_state['instance'])

func show_buildings():
	# For debugging
	if(building_count==0 || building_count > 5):
		print("Error while getting building count")
	else:
		for a in range(1,building_count + 1):
			get_node("Background/Building"+str(a)).show()

func get_building_count():
	return (game_data[global.selected_chapter_id]["Partitions"][global.selected_part_id]["Buildings"].size())


func done(status):
	# End of the part codes...
	# status can be state.CHAPTER_STATUS.SUCCESS or FAIL
	print("Game Over with"+str(status))

func _on_Building_released(selected_building_index):
	if(global.popup_opened):
		return
	var building_scene = ResourceLoader.load("res://scenes/BuildingScene.tscn")
	var building_instance = building_scene.instance()
	building_instance.building_index = selected_building_index
	add_child(building_instance)
	global.popup_opened = true
	pass # replace with function body