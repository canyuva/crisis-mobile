extends Control
var anim_state = true
func _ready():
	get_node("NextButton").hide()
	get_node("AnimationPlayer").play("Newspaper")
	pass

func _on_SkipButton_pressed():
	get_node("SkipButton").hide()
	get_node("NextButton").show()
	get_node("AnimationPlayer").play("FinishNewspaper")
	pass 

func _on_AnimationPlayer_animation_finished(anim_name):
	print("bok")
	get_node("SkipButton").hide()
	get_node("NextButton").show()
	pass 