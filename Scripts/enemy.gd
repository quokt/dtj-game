extends CharacterBody2D


@onready var target : Vector2 = get_tree().get_first_node_in_group("dancefloor").position + Vector2(randf_range(-200.0, 200.0), randf_range(-50.0,50.0))
var speed = 800.0


func _physics_process(delta: float) -> void:
	velocity = (target - position).normalized() * speed * delta
	move_and_slide()
