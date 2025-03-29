extends Tower

var elapsed : float = 0.0
func _process(delta: float) -> void:
	elapsed += delta
	$Sprite2D/ColorRect.material.set_shader_parameter("chaos", elapsed)
