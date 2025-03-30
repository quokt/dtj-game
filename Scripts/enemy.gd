extends CharacterBody2D

signal touched_speaker()

@onready var base_target : Vector2 = get_tree().get_first_node_in_group("dancefloor").position + Vector2(randf_range(-200.0, 200.0), randf_range(-50.0,50.0))

@export var speed = 2000.0
@export var attack_speed = 1000.0
 	
@export var idle_min_displacement : Vector2
@export var idle_max_displacement : Vector2

var countdown : float = randf_range(16.0, 36.0)

@export var override_target : Node2D = null

enum COLOR_STATE {BLUE, RED}
var color_state = COLOR_STATE.RED

enum STATE {ATTACK, FOLLOW, START, STUN}
var state : STATE = STATE.ATTACK

@export var stun_time = 3.00
var stun_elapsed : float = 0.0
var before_stun_state = STATE.FOLLOW

@export var score_increment : float

var wait_time : float = randf_range(0.5,3.0)
var elapsed : float = 0.0
var dance_target := Vector2(base_target.x + randf_range(10.0,60.0), base_target.y + randf_range(10.0,40.0))
var attack_target : Vector2
func _physics_process(delta: float) -> void:
	if color_state == COLOR_STATE.BLUE:
		get_tree().get_first_node_in_group("main").score += score_increment
	if randi()%4000 == 0:
		set_color_state(COLOR_STATE.RED)
	elapsed += delta
	match state:
		STATE.START:
			velocity = (base_target - position).normalized() * speed * delta
			if (base_target - position).length() <= 1.0:
				elapsed = 0.0
				state = STATE.FOLLOW
		STATE.FOLLOW:
			countdown -= delta
			if countdown <= 0.0:
				queue_free()
			velocity = (dance_target - position).normalized() * speed * delta
			if elapsed >= wait_time:
				dance_target = Vector2(base_target.x + randf_range(10.0,60.0), base_target.y + randf_range(10.0,40.0))
				elapsed = 0.0
				wait_time = randf_range(0.5,3.0)
		STATE.ATTACK:
			
			velocity = (attack_target - position).normalized() * attack_speed * delta
		STATE.STUN:
			stun_elapsed += delta
			if color_state == COLOR_STATE.RED :
				velocity = (attack_target - position).normalized() * -attack_speed * delta
			else:
				velocity = (attack_target - position).normalized() * attack_speed * delta
			if stun_elapsed >= stun_time:
				state = before_stun_state

	move_and_slide()

func set_color_state(new_color_state : COLOR_STATE) -> void:
	color_state = new_color_state
	match color_state:
		COLOR_STATE.RED:
			state = STATE.ATTACK
			if %Enemies:
				if randi()%2 and %Enemies.get_child_count() > 0:
					attack_target = %Enemies.get_children()[randi()%%Enemies.get_child_count()].position
			$Area2D.set_deferred("monitoring", true)
			#$Area2D.set_deferred("monitorable", true)
			$Blue.visible = false
			$Red.visible = true
		COLOR_STATE.BLUE:
			$Area2D.set_deferred("monitoring", false)
			#$Area2D.set_deferred("monitorable", false)
			state = STATE.FOLLOW
			$Red.visible = false
			$Blue.visible = true


func get_random_blue_enemy() -> Node2D:
	for enemy in %Enemies.get_children():
		if enemy.state_color != COLOR_STATE.BLUE:
			continue
		return enemy
	return 


func _ready() -> void:
	get_tree().get_first_node_in_group("gametime").tempo.connect(on_tempo)
	#print(get_tree().get_nodes_in_group("towers"))
	attack_target = Vector2(get_tree().get_nodes_in_group("towers")[randi()%get_tree().get_nodes_in_group("towers").size()].position)
	set_color_state(COLOR_STATE.RED)
	if not override_target == null:
		base_target = Vector2(override_target.position.x + randf_range(10.0,60.0), override_target.position.y + randf_range(10.0,40.0))
		dance_target = Vector2(override_target.position.x + randf_range(10.0,60.0), override_target.position.y + randf_range(10.0,40.0))
		attack_target = Vector2(override_target.position.x + randf_range(10.0,60.0), override_target.position.y + randf_range(10.0,40.0))


func on_player_touched() -> void:
	$AudioStreamPlayer2D.play()
	set_color_state(COLOR_STATE.BLUE)

func on_tempo():
	before_stun_state = state
	stun_elapsed = 0
	state = STATE.STUN
	pass

#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body is Tower:
		#body.take_damage(randf_range(min_damage, max_damage))
