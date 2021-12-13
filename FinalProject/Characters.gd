extends Node2D # this script could totally be removed


func _ready():
	$MultiTargetCamera.add_target($Dan)
	$MultiTargetCamera.add_target($Paul)

