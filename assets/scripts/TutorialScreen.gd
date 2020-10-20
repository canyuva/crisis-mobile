extends Control

func _ready():
	get_node("NextButton").hide()
	get_node("AnimationPlayer").play("TeacherComing")
	pass

func _on_NextButton_pressed():
	get_node("AnimationPlayer").play("StopTeacher")
	get_node("SkipButton").hide()
	get_node("NextButton").show()
	pass



