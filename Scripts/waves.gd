extends Node2D

@export var WAVE_LIFETIME = 5.0

var offset := 100.0

@export var wave_speed : float
@export var wave_accel : float
@export var thickness : float 

var waves_array := []

class Wave:
	var elapsed : float = 0.0
	var lifetime : float

func _draw() -> void:
	for tower in %Towers.get_children():
		var color : Color = Color.TURQUOISE
		if tower == %Table : color = Color.RED
		for wave in waves_array:
			draw_circle(tower.global_position, (wave.elapsed*wave.elapsed*wave_accel)*wave_speed*get_physics_process_delta_time(), color, false, (wave.lifetime-wave.elapsed)*(wave.lifetime-wave.elapsed)*thickness*get_physics_process_delta_time())

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
