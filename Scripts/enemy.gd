extends CharacterBody2D


@onready var base_target : Vector2 = get_tree().get_first_node_in_group("dancefloor").position + Vector2(randf_range(-200.0, 200.0), randf_range(-50.0,50.0))

@export var speed = 2000.0
@export var attack_speed = 1000.0

@export var idle_min_displacement : Vector2
@export var idle_max_displacement : Vector2

@export var override_target : Node2D = null

enum COLOR_STATE {BLUE, RED}
var color_state = COLOR_STATE.BLUE

enum STATE {ATTACK, FOLLOW, START}
var state : STATE = STATE.START

var wait_time : float = randf_range(0.5,3.0)
var elapsed : float = 0.0
var dance_target := Vector2(base_target.x + randf_range(10.0,60.0), base_target.y + randf_range(10.0,40.0))
var attack_target : Vector2
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
			velocity = (dance_target - position).normalized() * speed * delta
			if elapsed >= wait_time:
				dance_target = Vector2(base_target.x + randf_range(10.0,60.0), base_target.y + randf_range(10.0,40.0))
				elapsed = 0.0
				wait_time = randf_range(0.5,3.0)
		STATE.ATTACK:
			velocity = (attack_target - position).normalized() * attack_speed * delta
	move_and_slide()

func set_color_state(new_color_state : COLOR_STATE) -> void:
	color_state = new_color_state
	match color_state:
		COLOR_STATE.RED:
			state = STATE.ATTACK
			$Blue.visible = false
			$Red.visible = true
		COLOR_STATE.BLUE:
			state = STATE.FOLLOW
			$Red.visible = false
			$Blue.visible = true


func _ready() -> void:
	print(get_tree().get_nodes_in_group("towers"))
	attack_target = Vector2(get_tree().get_nodes_in_group("towers")[randi()%get_tree().get_nodes_in_group("towers").size()].position)
	set_color_state(COLOR_STATE.BLUE)
	if override_target:
		base_target = Vector2(override_target.position.x + randf_range(10.0,60.0), override_target.position.y + randf_range(10.0,40.0))
		dance_target = Vector2(override_target.position.x + randf_range(10.0,60.0), override_target.position.y + randf_range(10.0,40.0))
		attack_target = Vector2(override_target.position.x + randf_range(10.0,60.0), override_target.position.y + randf_range(10.0,40.0))


func on_player_touched() -> void:
	set_color_state(COLOR_STATE.BLUE)
