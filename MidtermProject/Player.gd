extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("place")):
		var x = get_global_mouse_position().x
		if(196<x && x<827):
			x -= 197
			x /= 90
			self.get_parent().get_node("GameState").place_chip(x as int)
			
