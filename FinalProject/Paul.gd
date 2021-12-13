extends KinematicBody2D
# go back and do time.delta time if he never ends up adressing it
# if both a and d are pressed -- special case

var velocity = Vector2(0,0)
const SPEED = 180
const GRAVITY = 1800
const JUMPFORCE = -1100

func _physics_process(delta):
	if Input.is_action_pressed("paul_right"):
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("paul_left"):
		velocity.x = -SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
	else:
		$Sprite.play("idle")
	
	if not is_on_floor():
		$Sprite.play("air")
	
	if Input.is_action_just_pressed("paul_jump") and is_on_floor():
		velocity.y = JUMPFORCE
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.2)
	velocity.y = velocity.y + GRAVITY * delta
