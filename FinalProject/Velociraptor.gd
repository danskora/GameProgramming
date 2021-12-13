extends KinematicBody2D

var velocity = Vector2()
export var direction = 1



func _ready():
	if direction == -1:
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = direction * 30

func _physics_process(delta):
	passive_behavior(delta)
	
	



func passive_behavior(delta):
	if is_on_wall() or not $FloorChecker.is_colliding() and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$FloorChecker.position.x = direction * 30
	
	#motion
	velocity.y += 1800 * delta
	velocity.x = direction * 100
	
	velocity = move_and_slide(velocity, Vector2.UP)

	
