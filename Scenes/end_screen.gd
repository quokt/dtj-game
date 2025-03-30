extends ColorRect


func _ready() -> void:
	get_tree().paused = true
	
	
func on_gameover() -> void:
	get_tree().paused = true
	$AudioStreamPlayer.volume_db = 0
	%MainAudioStreamPlayer.volume_db = -80.0

	$AnimationPlayer.play("appear")
	await($AnimationPlayer.animation_finished)


func _on_play_button_pressed() -> void:
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("vanish")
	$AudioStreamPlayer.volume_db = -80.0
	%MainAudioStreamPlayer.volume_db = 0


	await($AnimationPlayer.animation_finished)
	get_tree().paused = false




func _on_exit_button_pressed() -> void:
	get_tree().quit(0)
