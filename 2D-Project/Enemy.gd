extends Node2D

var _speed: float = 400

func _process(delta):
	position.y += _speed * delta


func _on_Area2D_area_entered(other_area: Area2D):
	self.queue_free()
	other_area.get_parent().queue_free()
	GameState.increase_score(1)
	
	if other_area.get_parent().name == "Player":
		GameState.initiate_game_over()
