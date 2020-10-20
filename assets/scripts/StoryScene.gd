extends Control

export (String) var next_scene_path = ""

var story_text = global.game_data[global.selected_chapter_id]["Partitions"][global.selected_part_id]["Description"]
var story_image = global.game_data[global.selected_chapter_id]["Partitions"][global.selected_part_id]["Image"]

func _ready():
	get_node("Background/StoryImage").set_texture(load(story_image))
	get_node("Background/NextButton").hide()
	get_node("Background/StoryText").set_text(story_text)
	typewriting_anim()
	pass

func _on_SkipButton_pressed():
	get_node("AnimationPlayer").seek(story_text.length()/10)
	get_node("Background/SkipButton").hide()
	get_node("Background/NextButton").show()
	pass # replace with function body


func _on_AnimationPlayer_animation_finished(anim_name):
	get_node("Background/SkipButton").hide()
	get_node("Background/NextButton").show()


func typewriting_anim():
	var typewriting_anim = Animation.new()
	var duration=story_text.length()/10;
	typewriting_anim.set_length(duration)
	typewriting_anim.add_track(Animation.TYPE_VALUE,0)
	typewriting_anim.track_set_path(0, "Background/StoryText:percent_visible")
	typewriting_anim.track_insert_key(0, 0, 0.0)
	typewriting_anim.track_insert_key(0, duration, 1.0)
	get_node("AnimationPlayer").add_animation("typewriting",typewriting_anim)
	get_node("AnimationPlayer").play("typewriting")

func _on_NextButton_released():
	global.goto_scene(next_scene_path)
	pass # replace with function body
