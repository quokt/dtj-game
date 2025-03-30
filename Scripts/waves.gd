extends Node2D

@export var WAVE_LIFETIME = 5.0

var offset := 100.0
var shockwave_scene := preload("res://Scenes/shockwave.tscn")

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
	var alpha : float = 1.0

func _draw() -> void:
	for tower in %Towers.get_children():
		if tower.active:
			tower.alpha = min(1.0, tower.alpha + get_physics_process_delta_time())
		else:
			tower.alpha = max(0.0, tower.alpha - get_physics_process_delta_time())
		var color : Color = color_speaker
		if tower == %Table : color = color_table
		for wave in waves_array:
			#if not tower.active:
				#wave.alpha = max(0.0, wave.alpha - get_physics_process_delta_time())
			#else:
				#wave.alpha = min(1.0, wave.alpha + get_physics_process_delta_time())
				#print(wave.alpha)
			color = Color(color, wave.alpha*tower.alpha)
			var radius : float = (wave.elapsed*wave.elapsed*wave_accel)*wave_speed*get_physics_process_delta_time()+wave_start
			var thickness = (wave.lifetime-wave.elapsed)*(wave.lifetime-wave.elapsed)*wave_thickness*get_physics_process_delta_time()
			draw_circle(tower.global_position, radius, color, false, thickness)
			draw_circle(tower.global_position, radius*3.0, Color(color, 0.1), false, thickness)
			draw_circle(tower.global_position, radius*6.0, Color(color, 0.08), false, thickness)


			
func _physics_process(delta: float) -> void:
	queue_redraw()
	for wave in waves_array:
		#print(wave.lifetime)
		wave.elapsed += delta
		if wave.elapsed >= wave.lifetime:
			waves_array.erase(wave)
			
	

var beat_count = 0

func _on_beat() -> void:
	
	beat_count += 1
	#print(self)
	var new_wave := Wave.new()
	new_wave.lifetime = WAVE_LIFETIME
	waves_array.append(new_wave)
	
	# create shockwave
	if beat_count%8 == 0:
		for tower in %Towers.get_children():
			if tower.active:
				var new_shockwave = shockwave_scene.instantiate()
				var shader_position = Vector2(remap(tower.position.x, -239, 227, 0.15, 0.85 ), remap(%Player.position.y,-140, -460, 0, 0.35))
				%ShockWaves.add_child(new_shockwave)
				new_shockwave.set_shader_position(shader_position)
				print(shader_position)
			
		
	return
