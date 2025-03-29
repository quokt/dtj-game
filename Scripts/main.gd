extends Node

var enemy_scene := preload("res://Scenes/enemy.tscn")

@export var enemy_waves : Array[EnemyWave]

signal enemy_wave(enemy_wave : EnemyWave)


func _ready() -> void:
	_on_wave_timer_timeout()


func _on_wave_timer_timeout() -> void:
	if enemy_waves.is_empty():
		%WaveTimer.stop()
		return
	var wave : EnemyWave = enemy_waves.pop_front()
	spawn_enemies_from_wave(wave)
	enemy_wave.emit(wave)
	%WaveTimer.start(wave.cooldown_time)
	print(%WaveTimer.wait_time)


func spawn_enemies_from_wave(wave : EnemyWave) -> void:
	for enemy in range(wave.enemy_amount):
		var new_enemy = enemy_scene.instantiate()
		%Enemies.add_child(new_enemy)
		new_enemy.position = Vector2(randf_range(-320,320), %Camera.position.x-80.0)


func _on_speaker_clicked(ref: Tower) -> void:
	for child in %Towers.get_children():
		child.active = child == ref
