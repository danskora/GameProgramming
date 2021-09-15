extends Node2D

var _speed: float = 150
var angle: float = 0
var center_x := position.x
var center_y := position.y

func _process(delta):
	center_y += _speed * delta
	angle += 3 * delta
	position.x = center_x - 70*sin(angle)
	position.y = center_y - 70*cos(angle)


func _on_Area2D_area_entered(other_area: Area2D):
	self.queue_free()
	other_area.get_parent().queue_free()
	GameState.increase_score(10)
	
	if other_area.get_parent().name == "Player":
		GameState.initiate_game_over()
