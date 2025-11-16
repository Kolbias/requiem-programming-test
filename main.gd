extends Node3D

## Signals for swapping environments
signal swap_environment_calm
signal swap_environment_blind

## Establish environment vars
var calm_environment: Environment
var blind_environment: Environment

## Enum for modes
enum Mode {CALM, BLIND}
var current_mode = Mode.CALM
var world_environment: WorldEnvironment

func _ready():
	## Wait for tree to be established and then set the environment
	await get_tree().process_frame
	world_environment = get_tree().current_scene.get_node("WorldEnvironment")
	if world_environment == null:
		print("WorldEnvironment node not found!")
		
	## Load the environments
	calm_environment = load("res://calm_environment.tres")
	blind_environment = load("res://blind_environment.tres")
	connect("swap_environment_calm", _on_swap_environment_calm)
	connect("swap_environment_blind", _on_swap_environment_blind)

## Functions to swap environments
func _on_swap_environment_blind():
	if world_environment == null:
		print("no world environment")
		return
	if current_mode == Mode.CALM:
		world_environment.environment = blind_environment
		current_mode = Mode.BLIND

func _on_swap_environment_calm():
	if world_environment == null:
		print("no world environment")
		return
	if current_mode == Mode.BLIND:
		world_environment.environment = calm_environment
		current_mode = Mode.CALM
