extends CharacterBody2D

signal enemy_touched(enemy)

#@export var walk_speed : float
#@export var run_speed : float
var base_speed = 140.0
var slow_speed := 60.0


var slow : bool = false

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up","down")).normalized()
	var speed = base_speed

	if direction != Vector2.ZERO:
		speed = slow_speed if slow else base_speed
		velocity = direction * speed
	else:
		velocity = Vector2(move_toward(velocity.x, 0, speed), move_toward(velocity.y, 0, speed))

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	enemy_touched.emit(body)





func _on_game_time_tempo() -> void:
	await(get_tree().create_timer(0.4).timeout)
	slow = true
	await(get_tree().create_timer(0.4).timeout)
	slow = false
