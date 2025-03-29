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
		
func die() -> void:
	died.emit()
	queue_free()
