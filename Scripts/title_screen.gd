extends TextureRect





func _ready() -> void:
	$AudioStreamPlayer.play()
	get_tree().paused = true
	
	
func on_pause() -> void:
	get_tree().get_first_node_in_group("main").reset()
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.volume_db = 0
	%MainAudioStreamPlayer.volume_db = -80.0
	$AnimationPlayer.play("appear")
	await($AnimationPlayer.animation_finished)
	get_tree().paused = true



func _on_play_button_pressed() -> void:
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("vanish")
	$AudioStreamPlayer.volume_db = -80.0
	%MainAudioStreamPlayer.volume_db = 0


	await($AnimationPlayer.animation_finished)
	get_tree().paused = false




func _on_exit_button_pressed() -> void:
	get_tree().quit(0)


func _on_rules_button_pressed() -> void:
	$ColorRect.visible = true


func _on_exit_button_2_pressed() -> void:
	$ColorRect.visible = false
