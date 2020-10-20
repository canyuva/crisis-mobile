extends Node
var crisis_bar = {}

enum CHAPTER_STATUS{FAIL, SUCCESS, NORMAL}

#Sets LastCrisisBarPos from user_data.dat and updates bar position
func set_bar_percent(percent):
	var ret_status
	if percent>=100:
		percent=100
		ret_status = CHAPTER_STATUS.FAIL
		
	elif percent<=0:
		percent=0
		ret_status = CHAPTER_STATUS.SUCCESS
	else:
		ret_status = CHAPTER_STATUS.NORMAL

	global.user_data["ChaptersData"][global.user_data["LastChapter"]]["LastCrisisBarPos"] = percent
	global.save_game_data()
	update_bar_percent()
	return ret_status
	
#Returns current LastCrisisBarPos from user_data.dat
func get_bar_percent():
	return global.user_data["ChaptersData"][global.user_data["LastChapter"]]["LastCrisisBarPos"]

#Gets the LatstCrisisBarPosition from user_data.dat and update crisis bar
func update_bar_percent():
	if(crisis_bar.has('instance')):
		var percent=get_bar_percent()
		crisis_bar['instance'].bar_resize_anim(percent)
	else:
		print("There is no instance of crisis bar")