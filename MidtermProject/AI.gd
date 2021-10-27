extends Node2D


var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func ai_process():
	var x = rng.randi_range(0, 6)
	self.get_parent().get_node("GameState").place_chip(x)
