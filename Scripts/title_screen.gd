extends ColorRect


func _ready() -> void:
	get_tree().paused = true
	
	
func on_pause() -> void:
	get_tree().paused = true
	visible = true


func _on_play_button_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_exit_button_pressed() -> void:
	get_tree().quit(0)
