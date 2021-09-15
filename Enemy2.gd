extends Node2D

var _speed: float = 200
var dir = randi() % 2 == 0

func _process(delta):
	position.y += _speed * delta
	if dir:
		position.x += _speed * delta *.6
	else:
		position.x -= _speed * delta *.6


func _on_Area2D_area_entered(other_area: Area2D):
	self.queue_free()
	other_area.get_parent().queue_free()
	GameState.increase_score(3)
	
	if other_area.get_parent().name == "Player":
		GameState.initiate_game_over()

func switch_direction():
	dir = !dir
