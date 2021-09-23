extends Node2D

export var _enemy_scene1: PackedScene
export var _enemy_scene2: PackedScene
export var _enemy_scene3: PackedScene

func spawn_enemy() -> void:
	var new_enemy
	if GameState.score < 10:
		new_enemy = _enemy_scene1.instance() as Node2D
	elif GameState.score < 30:
		if randf() < .6:
			new_enemy = _enemy_scene1.instance() as Node2D
		else:
			new_enemy = _enemy_scene2.instance() as Node2D
	else:
		if randf() < .4:
			new_enemy = _enemy_scene1.instance() as Node2D
		elif randf() < .5:
			new_enemy = _enemy_scene2.instance() as Node2D
		else:
			new_enemy = _enemy_scene3.instance() as Node2D
	
	
	self.add_child(new_enemy)
	
	var rand_x := rand_range(0, get_viewport_rect().size.x)
	new_enemy.position = Vector2(rand_x, -50)
