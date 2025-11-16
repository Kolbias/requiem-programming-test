extends Label

func _ready() -> void:
	Main.connect("swap_environment_blind", _on_swap_text_blind)
	Main.connect("swap_environment_calm", _on_swap_text_calm)
	
func _on_swap_text_blind():
	text = "BLIND MODE"
	
func _on_swap_text_calm():
	text = "CALM MODE"
