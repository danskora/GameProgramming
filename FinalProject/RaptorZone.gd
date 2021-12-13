extends Area2D



func _on_Area2D_body_entered(body):
	if body.get_name() == "Dan":
		get_parent().queue_free()
	if body.get_name() == "Paul":
		get_parent().get_parent().get_parent().get_node("Fundamentals/SceneTransition").transition_to("res://Level1.tscn")
