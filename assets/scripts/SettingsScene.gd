extends Control
var music_value = 0;
var fx_value=0


func _ready():
	get_node("AnimationPlayer").play("SettingsAnim")
	
	if(music_value == 0):
		get_node("Control/MusicOnButton").hide()
		get_node("Control/MusicOffButton").show()
	else:
		get_node("Control/MusicOnButton").show()
		get_node("Control/MusicOffButton").show()
	
	if(fx_value == 0):
		get_node("Control/EffectOnButton").hide()
		get_node("Control/EffectOffButton").show()
	else:
		get_node("Control/EffectOffButton").hide()
		get_node("Control/EffectOnButton").show()
	
	get_node("Control/EnglishButton").hide()
	pass

func _on_MusicOnButton_pressed():
	get_node("Control/MusicOnButton").hide()
	get_node("Control/MusicOffButton").show()
	get_node("Control/MusicHSlider").value = 0
	pass # replace with function body

func _on_MusicOffButton_pressed():
	get_node("Control/MusicOffButton").hide()
	get_node("Control/MusicOnButton").show()
	pass # replace with function body


func _on_EffectOnButton_pressed():
	get_node("Control/EffectOnButton").hide()
	get_node("Control/EffectOffButton").show()
	get_node("Control/EffectHSlider").value = 0
	pass # replace with function body


func _on_EffectOffButton_pressed():
	get_node("Control/EffectOffButton").hide()
	get_node("Control/EffectOnButton").show()
	pass # replace with function body


func _on_EnglishButton_pressed():
	get_node("Control/EnglishButton").hide()
	get_node("Control/TurkishButton").show()
	pass # replace with function body


func _on_TurkishButton_pressed():
	get_node("Control/TurkishButton").hide()
	get_node("Control/EnglishButton").show()
	pass # replace with function body

func _on_MusicHSlider_value_changed(value):
	music_value=value;
	if(value == 0):
		get_node("Control/MusicOnButton").hide()
		get_node("Control/MusicOffButton").show()
	
	else:
		get_node("Control/MusicOffButton").hide()
		get_node("Control/MusicOnButton").show()
	
	pass # replace with function body


func _on_EffectHSlider_value_changed(value):
	fx_value = value
	if(value == 0):
		get_node("Control/EffectOnButton").hide()
		get_node("Control/EffectOffButton").show()
	else:
		get_node("Control/EffectOffButton").hide()
		get_node("Control/EffectOnButton").show()
	pass # replace with function body
