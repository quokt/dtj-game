extends Node2D

@export var WAVE_LIFETIME = 5.0

var offset := 100.0

@export var wave_speed : float
@export var wave_accel : float
@export var wave_thickness : float 
@export var wave_start : float

@export var color_table : Color
@export var color_speaker : Color

var waves_array := []

class Wave:
	var elapsed : float = 0.0
	var lifetime : float

func _draw() -> void:
	for tower in %Towers.get_children():
		var color : Color = color_speaker
		if tower == %Table : color = color_table
		for wave in waves_array:
			draw_circle(tower.global_position, (wave.elapsed*wave.elapsed*wave_accel)*wave_speed*get_physics_process_delta_time()+wave_start, color, false, (wave.lifetime-wave.elapsed)*(wave.lifetime-wave.elapsed)*wave_thickness*get_physics_process_delta_time())
			draw_circle(tower.global_position, (wave.elapsed*wave.elapsed*wave_accel)*wave_speed*get_physics_process_delta_time()+wave_start, Color(color, 0.1), false, (wave.lifetime-wave.elapsed)*(wave.lifetime-wave.elapsed)*wave_thickness*20.0*get_physics_process_delta_time())
func _physics_process(delta: float) -> void:
	queue_redraw()
	for wave in waves_array:
		#print(wave.lifetime)
		wave.elapsed += delta
		if wave.elapsed >= wave.lifetime:
			waves_array.erase(wave)


func _on_beat() -> void:
	#print(self)
	var new_wave := Wave.new()
	new_wave.lifetime = WAVE_LIFETIME
	waves_array.append(new_wave)
	return
