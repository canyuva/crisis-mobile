extends Node

func _ready():
	global.popup_opened=true

func _on_YesButton_released():
	get_tree().quit()
	
func _on_NoButton_released():
	self.queue_free()
	
func _exit_tree():
	global.popup_opened=false