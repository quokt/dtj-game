extends CharacterBody2D

signal enemy_touched(enemy)

@export var walk_speed : float
@export var run_speed : float

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up","down")).normalized()
	if direction != Vector2.ZERO:
		var speed
		if Input.is_action_pressed("run"):
			speed = run_speed
		else :
			speed = walk_speed
		velocity = direction * speed
	else:
		velocity = Vector2(move_toward(velocity.x, 0, walk_speed), move_toward(velocity.y, 0, walk_speed))

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	enemy_touched.emit(body)
