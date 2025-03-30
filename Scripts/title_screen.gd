extends ColorRect


func _ready() -> void:
	get_tree().paused = true
	
	
func on_pause() -> void:
	get_tree().paused = true
	$AnimationPlayer.play("appear")
	await($AnimationPlayer.animation_finished)


func _on_play_button_pressed() -> void:
	$AnimationPlayer.play("vanish")
	await($AnimationPlayer.animation_finished)
	get_tree().paused = false




func _on_exit_button_pressed() -> void:
	get_tree().quit(0)
