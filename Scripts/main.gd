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
	var wave = enemy_waves.pop_front()
	spawn_enemies_from_wave(wave)
	enemy_wave.emit(wave)
	%WaveTimer.wait_time = wave.cooldown_time


func spawn_enemies_from_wave(wave : EnemyWave) -> void:
	for enemy in range(wave.enemy_amount):
		var new_enemy = enemy_scene.instantiate()
		%Enemies.add_child(new_enemy)
		new_enemy.position = Vector2(randf_range(0,1920), randf_range(0,1080))
