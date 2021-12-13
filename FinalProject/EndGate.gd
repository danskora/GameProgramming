extends Area2D


func _on_EndGate_body_entered(body):
	if get_overlapping_bodies().size() > 1:
		get_parent().get_node("SceneTransition").transition_to("res://EndScreen.tscn")
