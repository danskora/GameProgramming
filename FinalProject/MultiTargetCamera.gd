extends Camera2D

export var move_speed = 0.5
export var zoom_speed = 0.05
export var min_zoom = 1
var margin = Vector2(400,200)

var targets = [] # remove the array maybe??

# if i make "fundamentals" a scene, how will i set the camera limits for different levels?? (eyebrow raise emoji)

onready var screen_size = get_viewport_rect().size
onready var max_zoom = max(min_zoom, min((limit_right - limit_left), (limit_bottom - limit_top) * screen_size.aspect()) / screen_size.x)

func add_target(t):
	if not t in targets:
		targets.append(t)

func remove_target(t):
	if t in targets:
		targets.remove(t)

func _process(delta):
	
	screen_size = get_viewport_rect().size
	max_zoom = max(min_zoom, min((limit_right - limit_left), (limit_bottom - limit_top) * screen_size.aspect()) / screen_size.x)
	
	# create a rectangle containing all targets
	var r = Rect2(targets[0].position, Vector2.ZERO)
	r = r.expand(targets[1].position)
	
	# add margins to rectangle
	r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)
	
	# find the center and set it
	var desired_pos = r.position + r.size / 2
	position = lerp(position, desired_pos, move_speed)
	
	# find the zoom and set it
	var desired_zoom = clamp(max(r.size.x, r.size.y * screen_size.aspect()) / screen_size.x, min_zoom, max_zoom)
	zoom = lerp(zoom, Vector2.ONE * desired_zoom, zoom_speed)
