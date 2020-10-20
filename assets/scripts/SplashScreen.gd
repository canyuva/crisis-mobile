extends Control

export (String) var next_scene = ""

func _on_AnimationPlayer_animation_finished(anim_name):
	global.goto_scene(next_scene)
