extends Control

onready var anim_player=get_node("AnimationPlayer")
onready var bar_path = "BarBG/Bar"
#Max width of bar scale
onready var max_bar_size = 550
#Duration of animation
onready var duration = 4

func bar_resize_anim(percent):
	var bar=get_node(bar_path)
	var size_of_percent=remap(percent,0,100,0,max_bar_size)
	var old_size = bar.get_size()
	var new_size=Vector2 (size_of_percent, old_size.y)
	var old_color=bar.color
	var red_val=remap(percent,0,100,0.0,1.0)
	var green_val=remap(percent,0,100,1.0,0.0)
	var new_color=Color(red_val,green_val,0.0,1.0)
	var anim=Animation.new()
	anim.set_length(duration)
	
	anim.add_track(Animation.TYPE_VALUE,0)
	anim.track_set_path(0, bar_path+":rect_size")
	anim.track_insert_key(0, 0, old_size)
	anim.track_insert_key(0, duration, new_size)
	anim.track_set_key_transition(0,0,3)
	
	anim.add_track(Animation.TYPE_VALUE,1)
	anim.track_set_path(1, bar_path+":color")
	anim.track_insert_key(1, 0, old_color)
	anim.track_insert_key(1, duration, new_color)
	
	anim_player.add_animation("anim",anim)
	anim_player.play("anim")
	pass

func remap(x, in_min, in_max, out_min, out_max):
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min