extends CharacterBody2D


@onready var base_target : Vector2 = get_tree().get_first_node_in_group("dancefloor").position + Vector2(randf_range(-200.0, 200.0), randf_range(-50.0,50.0))
var speed = 2000.0

@export var idle_min_displacement : Vector2
@export var idle_max_displacement : Vector2

enum COLOR_STATE {BLUE, RED}
var color_state = COLOR_STATE.BLUE

enum STATE {IDLE, FOLLOW, START}
var state : STATE = STATE.START

var wait_time : float = randf_range(0.5,3.0)
var elapsed : float = 0.0
var target : Vector2 = Vector2(base_target.x + randf_range(10.0,60.0), base_target.y + randf_range(10.0,40.0))
func _physics_process(delta: float) -> void:
	if randi()%10000 == 0:
		set_color_state(COLOR_STATE.RED)
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

func set_color_state(new_color_state : COLOR_STATE) -> void:
	color_state = new_color_state
	match color_state:
		COLOR_STATE.RED:
			$Blue.visible = false
			$Red.visible = true
		COLOR_STATE.BLUE:
			$Red.visible = false
			$Blue.visible = true


func _ready() -> void:
	set_color_state(COLOR_STATE.BLUE)


func on_player_touched() -> void:
	set_color_state(COLOR_STATE.BLUE)
