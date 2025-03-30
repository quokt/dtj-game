extends Tower

signal clicked(ref : Tower)

var mouse_inside : bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click") and mouse_inside:
			print("clicked")
			clicked.emit(self)


func _on_area_2d_area_entered(area: Area2D) -> void:
	mouse_inside = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	mouse_inside = false
