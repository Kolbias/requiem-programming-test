extends Area3D

## Simple trigger to swap environment via Global/Autoload (singleton)
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Main.emit_signal("swap_environment_calm")
