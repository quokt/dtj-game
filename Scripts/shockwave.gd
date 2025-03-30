extends Node2D

var elapsed : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_shader_position( pos: Vector2):	
	$shockwave_shader.material.set_shader_parameter("center", pos)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed += delta
	$shockwave_shader.material.set_shader_parameter("radius", elapsed*0.5)
	if elapsed >= 3:
		queue_free()
	pass
