extends Area2D

var elapsed : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_shader_position( pos: Vector2):	
	$shockwave_shader.material.set_shader_parameter("center", pos)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for tower in get_tree().get_nodes_in_group("towers"):
		if tower.active:
			position = tower.position
	elapsed += delta
	$shockwave_shader.material.set_shader_parameter("radius", elapsed)
	if elapsed >= 2:
		queue_free()
	pass
