extends Node2D

var fov = 10
var images = []
var depths = []

onready var cam = get_parent().get_node("MultiTargetCamera")

func _ready():
	for child in self.get_children():
		images.append(child.texture)
		depths.append(child.depth)


func _process(delta):
	
	# delete all existing children
	for child in self.get_children():
		child.queue_free()
	
	var level_height = cam.limit_bottom - cam.limit_top
	#var camera_height = 600 * cam.zoom.y
	#var camera_width = 1024 * cam.zoom.x
	var camera_height = get_viewport_rect().size.y * cam.zoom.y
	var camera_width = get_viewport_rect().size.x * cam.zoom.x
	var true_camera_position = Vector2(clamp(cam.position.x, cam.limit_left + (camera_width/2), cam.limit_right - (camera_width/2)), clamp(cam.position.y, cam.limit_top + (camera_height/2), cam.limit_bottom - (camera_height/2)))
	
	
	
	
	for _i in range(images.size()):
		
		# determine the appropriate scale
		var true_layer_height = level_height + (2 * depths[_i] * tan(fov))
		var visible_layer_height = camera_height + (2 * depths[_i] * tan(fov))
		var layer_scale = (true_layer_height / 216) * (camera_height / visible_layer_height)
		
		# determine the appropriate y position
		var level_center = (cam.limit_bottom + cam.limit_top) / 2
		var relative_camera_position = level_center - true_camera_position.y
		var fraction = relative_camera_position / true_layer_height
		var position_y = true_camera_position.y + (fraction * layer_scale * 216)
		
		# determine the appropriate x position
		fraction = true_camera_position.x / (true_layer_height * 384 / 216)
		var position_x = true_camera_position.x - (fraction * layer_scale * 384)
		
		# tile the layer
		var image_edge = position_x + (192 * layer_scale)
		var cam_range = Vector2(true_camera_position.x - (camera_width/2), true_camera_position.x + (camera_width/2) + (layer_scale * 192)) # this is a sloppy, asymmetrical vector that is tailored for my specific purposes
		var adjusted_left = cam_range.x - image_edge
		var n = int(floor(adjusted_left / (384 * layer_scale)))
		
		# find the center for the first image in the tiling and repeatedly adjust it to create new images
		var center = image_edge + ((n + 0.5) * 384 * layer_scale)
		while center < cam_range.y:
			var sprite = Sprite.new()
			sprite.set_texture(images[_i])
			sprite.set_position(Vector2(center, position_y))
			sprite.set_scale(Vector2(layer_scale, layer_scale))
			add_child(sprite)
			center += layer_scale * 384
		
		
