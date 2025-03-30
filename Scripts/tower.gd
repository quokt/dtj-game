extends Node2D
class_name Tower

signal died

@export var amount_max : int = 200
@export var amount_min : int = 1

var alpha : float = 0.0
var active : bool = false

@onready var main = get_tree().get_first_node_in_group("main")


@export var max_chaos : float
var chaos : float = 0.0

func _ready() -> void:
	add_to_group("towers")
	

func _physics_process(delta: float) -> void:
	$GPUParticles2D.amount = remap(main.score, 0.0, main.win_score, amount_min, amount_max)

func take_damage(amount : float) -> void:
	chaos += amount*4.0
	main.global_chaos += amount*4.0
	var _material = $AnimatedSprite2D/ColorRect.material
	_material.set_shader_parameter("chaos", chaos)
	get_tree().get_first_node_in_group("main").score = max(0.0,	get_tree().get_first_node_in_group("main").score - 0.008)
	if chaos >= max_chaos:
		die()
		
func die() -> void:
	died.emit()
	#queue_free()
