extends ColorRect

func _ready():
	var p = get_parent().get_node("MultiTargetCamera")
	rect_position = Vector2(p.limit_left, p.limit_top)
	rect_size = Vector2(p.limit_right - p.limit_left, p.limit_bottom - p.limit_top)
	$AnimationPlayer.play_backwards("Fade")

func transition_to(_next_scene):
	$AnimationPlayer.play("Fade")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(_next_scene)

func _on_FallZone_body_entered(body):
	transition_to("res://"+get_tree().get_current_scene().get_name()+".tscn") 
	# this won't work if I move the levels into a folder
	# however, I don't know a better way
