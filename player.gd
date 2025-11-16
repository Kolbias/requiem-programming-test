extends CharacterBody3D

## Set speed and jump amount, allows for simple adjustments in the editor
@export var speed = 7.0
@export var jump_velocity = 10.0

func _physics_process(delta: float) -> void:
	## Get the input direction
	var input_dir = 0.0 
	if Input.is_action_pressed("ui_right"):
		input_dir = 1.0
	elif Input.is_action_pressed("ui_left"):
		input_dir = -1.0
	
	## Handle Velocities 
	velocity.x = input_dir * speed
	_handle_air_movement(delta)
	
	move_and_slide()

## Function to handle the air movement & gravity
func _handle_air_movement(delta):
		if not is_on_floor():
			velocity.y += get_gravity().y * delta
			
		if Input.is_action_just_pressed("ui_select") and is_on_floor():
			velocity.y = jump_velocity
