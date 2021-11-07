extends KinematicBody2D

const UP = Vector2(0, -1);
const GRAVITY = 20
const MAX_FALL_SPEED = 200
const MAX_MOVE_SPEED = 80
const JUMP_FORCE = 275
const ACCEL = 10

var motion = Vector2()
var facing_right = true

func _ready():
	pass

func _physics_process(delta):
	
	motion.y += GRAVITY
	
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
	
	if motion.y > MAX_FALL_SPEED:
		motion.y = MAX_FALL_SPEED
	
	motion.x = clamp(motion.x, -MAX_MOVE_SPEED, MAX_MOVE_SPEED)
	
	if Input.is_action_pressed("left"):
		motion.x -= ACCEL
		facing_right = false
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("right"):
		motion.x += ACCEL
		facing_right = true
		$AnimationPlayer.play("Run")
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		$AnimationPlayer.play("Idle")
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_FORCE

	motion = move_and_slide(motion, UP)
