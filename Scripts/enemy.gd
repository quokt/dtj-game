extends CharacterBody2D


@onready var target : Tower = get_tree().get_nodes_in_group("towers")[randi()%get_tree().get_nodes_in_group("towers").size()-1]
var speed = 800.0


func _physics_process(delta: float) -> void:
	velocity = (target.position - position).normalized() * speed * delta
	move_and_slide()
