extends Node2D
class_name Tower

signal died

var alpha : float = 0.0
var active : bool = false

@export var max_chaos : float
var chaos : float = 0.0

func _ready() -> void:
	add_to_group("towers")

func take_damage(amount : float) -> void:
	chaos += amount*2.0
	var _material = $AnimatedSprite2D/ColorRect.material
	_material.set_shader_parameter("chaos", chaos)
	get_tree().get_first_node_in_group("main").score = max(0.0,	get_tree().get_first_node_in_group("main").score - 0.008)
	if chaos >= max_chaos:
		die()
		
func die() -> void:
	died.emit()
	queue_free()
