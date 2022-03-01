extends KinematicBody2D

const SPEED = 1000
const GRAVITY = 4000
const JUMP_SPEED = 2000;
const WORLD_LIMIT = 4000;
const JUMP_MULITPLIER = 1.3

var motion = Vector2(0, 0)
var is_hurt = false

signal animate

func _physics_process(delta):
	apply_gravity(delta)
	cancelHurt()
	jump()
	interrump_jump()
	move_horizontal()
	animate()
	game_over()
	motion = move_and_slide(motion, Vector2.UP)

func jump():
	if(Input.is_action_pressed("jump") and is_on_floor()):
		$jumpFX.play()
		motion.y = -JUMP_SPEED
	
func move_horizontal():
	motion.x = (Input.get_action_strength("right") - Input.get_action_strength("left"))*SPEED
	
func apply_gravity(delta):
	motion.y += GRAVITY * delta
	
func animate():
	emit_signal("animate", motion, is_hurt)
	
func interrump_jump():
	if Input.is_action_just_released("jump") and motion.y < 0:
		motion.y = 0
		
func hurt():
	motion.y = -JUMP_SPEED
	is_hurt = true
	$hurtFX.play()

func cancelHurt():
	if is_on_floor() && motion.y > 0:
		is_hurt = false
	
func game_over():
	if motion.y > WORLD_LIMIT:
		get_tree().call_group("game_state", "end_game")
		
func boost():
	motion.y = -JUMP_SPEED * JUMP_MULITPLIER
	
