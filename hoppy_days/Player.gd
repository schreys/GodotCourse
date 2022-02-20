extends KinematicBody2D

var motion = Vector2(0, 0)
const SPEED = 500
const GRAVITY = 2000
const UP = Vector2(0, -1);
const JUMP_SPEED = 1000;

func _physics_process(delta):
	apply_gravity(delta)
	jump()
	move_horizontal()
	animate()
	motion = move_and_slide(motion, UP)

func jump():
	if(Input.is_action_pressed("jump") and is_on_floor()):
		motion.y = -JUMP_SPEED

func move_horizontal():
	motion.x = (Input.get_action_strength("right") - Input.get_action_strength("left"))*SPEED
	
func apply_gravity(delta):
	motion.y += GRAVITY * delta
	
func animate():
	if(motion.y < 0):
		$AnimatedSprite.play("jump")
	elif(motion.x != 0):
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = motion.x < 0
			
	else:
		$AnimatedSprite.play("idle")
	