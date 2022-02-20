extends KinematicBody2D

var motion = Vector2(0, 0)
const SPEED = 1000
const GRAVITY = 4000
const JUMP_SPEED = 2000;
const WORLD_LIMIT = 4000;

signal animate

func _physics_process(delta):
	apply_gravity(delta)
	jump()
	interrump_jump()
	move_horizontal()
	animate()
	motion = move_and_slide(motion, Vector2.UP)

func jump():
	if(Input.is_action_pressed("jump") and is_on_floor()):
		motion.y = -JUMP_SPEED

func move_horizontal():
	motion.x = (Input.get_action_strength("right") - Input.get_action_strength("left"))*SPEED
	
func apply_gravity(delta):
	if motion.y > WORLD_LIMIT: 
		get_tree().change_scene("res://Levels/GameOver.tscn")
	motion.y += GRAVITY * delta
	
func animate():
	emit_signal("animate", motion)
	
func interrump_jump():
	if Input.is_action_just_released("jump") and motion.y < 0:
		motion.y = 0