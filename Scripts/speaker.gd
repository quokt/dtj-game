extends Tower

signal clicked(ref: Tower)

var mouse_inside : bool = false

var attack_counter : int = 0


var elapsed : float = 0.0
func _process(delta: float) -> void:
	if attack_counter > 0:
		pass
	for i in range(attack_counter):
		take_damage(randf_range(0.001,0.005))
	#elapsed += delta
	#$AnimatedSprite2D/ColorRect.material.set_shader_parameter("chaos", elapsed)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click") and mouse_inside:
			print("clicked")
			clicked.emit(self)


func _on_area_2d_area_entered(_area: Area2D) -> void:
	mouse_inside = true

func _on_area_2d_area_exited(_area: Area2D) -> void:
	mouse_inside = false


func _on_area_2d_3_body_entered(body: Node2D) -> void:
	attack_counter += 1


func _on_area_2d_3_body_exited(body: Node2D) -> void:
	attack_counter -= 1
