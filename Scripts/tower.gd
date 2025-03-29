extends Node2D
class_name Tower

signal died

@export var health : int

func take_damage(amount : int) -> void:
	health = max(0, health - amount)
	if health <= 0:
		die()
		
func die() -> void:
	died.emit()
	queue_free()
