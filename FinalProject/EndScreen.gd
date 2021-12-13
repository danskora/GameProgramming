extends RichTextLabel


func _process(delta):
	if Input.is_action_pressed("Click"):
		get_tree().change_scene("res://Level1.tscn")
