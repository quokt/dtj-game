extends Node2D
class_name Tower

signal died

var alpha : float = 0.0
var active : bool = false

@export var health : int

func _ready() -> void:
	add_to_group("towers")

func take_damage(amount : int) -> void:
	health = max(0, health - amount)
	if health <= 0:
		die()
		
	var _material = $AnimatedSprite2D/ColorRect.material
	_material.set_shader_parameter("chaos", _material.get_shader_parameter("chaos") + float(amount))

		
func die() -> void:
	died.emit()
	queue_free()
