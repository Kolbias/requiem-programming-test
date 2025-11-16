extends CharacterBody3D

## Debug label to visualize states
@onready var state_label: Label3D = %StateLabel

## Set patrol length and chase speed, allows for simple adjustments in the editor
@export var patrol_length := 5.0
@export var chase_speed := 6.0

## State and var setup
enum States {PATROL, CHASE}
var state = States.PATROL

var move_forward := true
var start_x := 0.0 
var player_pos_x: float
var player: Node3D = null

func _ready() -> void:
	start_x = global_position.x

func _physics_process(delta: float) -> void:
	## Handle Gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	
	## Handle State Logic
	match state:
		
		States.PATROL:
			state_label.text = "PATROL"
			if move_forward:
				velocity.x = 5.0
			else:
				velocity.x = -5.0
			if global_position.x >= start_x + patrol_length:
				move_forward = false
			elif global_position.x <= start_x - patrol_length:
				move_forward = true
				
		States.CHASE:
			state_label.text = "CHASE"
			var dir = (player.global_position.x - global_position.x)
			if abs(dir) > 0.1:  ## Deadzone to prevent jitter
				velocity.x = chase_speed * sign(dir)
			else:
				velocity.x = 0.0

	move_and_slide()

func _change_state(new_state):
	state = new_state

## Detect player and change states accordingly
func _on_player_detection_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player = body
		print("player detected")
		player_pos_x = body.global_position.x
		_change_state(States.CHASE)

func _on_player_detection_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player = null
		print("player left area")
		_change_state(States.PATROL)
