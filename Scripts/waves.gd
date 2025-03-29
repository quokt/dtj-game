extends Node2D

const WAVE_LIFETIME = 5.0

var offset := 100.0

@export var wave_speed : float = 300.0

var waves_array := []

class Wave:
	var lifetime : float = 0.0

func _draw() -> void:
	for tower in %Towers.get_children():
		var color : Color = Color.GREEN
		if tower == %Table : color = Color.RED
		for wave in waves_array:
			draw_circle(tower.global_position, wave.lifetime*600.0, color, false, sin(get_process_delta_time())*100.0)


func _physics_process(delta: float) -> void:
	queue_redraw()
	for wave in waves_array:
		#print(wave.lifetime)
		wave.lifetime += get_physics_process_delta_time()
		if wave.lifetime >= WAVE_LIFETIME:
			waves_array.erase(wave)


func _on_beat() -> void:
	#print(self)
	var new_wave := Wave.new()
	waves_array.append(new_wave)
	
	
	return
