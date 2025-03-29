extends CharacterBody2D


@onready var base_target : Vector2 = get_tree().get_first_node_in_group("dancefloor").position + Vector2(randf_range(-200.0, 200.0), randf_range(-50.0,50.0))
var speed = 2000.0

@export var idle_min_displacement : Vector2
@export var idle_max_displacement : Vector2


enum STATE {IDLE, FOLLOW, START}
var state : STATE = STATE.START

var wait_time : float = randf_range(0.5,3.0)
var elapsed : float = 0.0
var target : Vector2 = Vector2(base_target.x + randf_range(10.0,60.0), base_target.y + randf_range(10.0,40.0))
func _physics_process(delta: float) -> void:
	elapsed += delta
	match state:
		STATE.START:
			velocity = (base_target - position).normalized() * speed * delta
			if (base_target - position).length() <= 1.0:
				elapsed = 0.0
				state = STATE.FOLLOW
		STATE.FOLLOW:
			velocity = (target - position).normalized() * speed * delta
			if elapsed >= wait_time:
				target = Vector2(base_target.x + randf_range(10.0,60.0), base_target.y + randf_range(10.0,40.0))
				elapsed = 0.0
				wait_time = randf_range(0.5,3.0)
	move_and_slide()
