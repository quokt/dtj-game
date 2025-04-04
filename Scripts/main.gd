extends Node

var score : float = 0.0
var global_chaos : float

var max_global_chaos : float = 30.0
var win_score : float = 1000000.0

var enemy_scene := preload("res://Scenes/enemy.tscn")

@export var enemy_waves : Array[EnemyWave]
@onready var _enemy_waves : Array = enemy_waves.duplicate(true)

signal enemy_wave(enemy_wave : EnemyWave)


func reset() -> void:
	score = 0.0
	global_chaos = 0.0
	for enemy in %Enemies.get_children():
		enemy.queue_free()
	_enemy_waves = enemy_waves.duplicate(true)
	%ScoreLabel.get_parent().visible = true
	for tower in %Towers.get_children():
		if tower.has_node("AnimatedSprite2D/ColorRect"):
			tower.get_node("AnimatedSprite2D/ColorRect").material.set_shader_parameter("chaos", 0.0)
			tower.chaos = 0.0
	game_on = true
	


var fullscreen_on : bool = false
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("pause"):
			%TitleScreen.on_pause()
		if event.is_action_pressed("fullscreen"):
			if not fullscreen_on:
				get_window().mode = Window.MODE_FULLSCREEN
			else:
				get_window().mode = Window.MODE_WINDOWED
			fullscreen_on = not fullscreen_on

func _ready() -> void:
	%Player.enemy_touched.connect(on_player_touched_enemy)
	_on_wave_timer_timeout()
	get_window().mode = Window.MODE_WINDOWED

var game_on : bool = true
func _process(delta: float) -> void:
	%Label.text = str(score, global_chaos)
	%ScoreLabel.text = str(int(score))
	if global_chaos >= max_global_chaos and game_on:
		%EndScreen.on_gameover()
		game_on = false
		
		


func _on_wave_timer_timeout() -> void:
	var wave : EnemyWave
	if _enemy_waves.is_empty():
		_enemy_waves = enemy_waves.duplicate(true)
		wave = _enemy_waves.pop_front()
	else:
		wave = _enemy_waves.pop_front()
	spawn_enemies_from_wave(wave)
	enemy_wave.emit(wave)
	%WaveTimer.start(wave.cooldown_time)


func spawn_enemies_from_wave(wave : EnemyWave) -> void:
	for enemy in range(wave.enemy_amount):
		var new_enemy = enemy_scene.instantiate()
		%Enemies.add_child(new_enemy)
		
		new_enemy.position = Vector2(randf_range(-320,320), %Camera.position.x-80.0)


func on_player_touched_enemy(enemy) -> void:
	enemy.on_player_touched()


func _on_speaker_clicked(ref: Tower) -> void:
	ref.active = not ref.active
	#for child in %Towers.get_children():
		#child.active = child == ref
