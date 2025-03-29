extends Node2D

const WAVE_LIFETIME = 40.0

var offset := 100.0
var dj_pos := Vector2(1920.0/2.0, 1080.0-offset)

var waves_array := []

class Wave:
	var lifetime : float = 0.0

func _draw() -> void:
	
	for wave in waves_array:
		draw_circle(dj_pos, wave.lifetime*600.0, Color.RED, false, sin(get_process_delta_time())*100.0)


func _physics_process(delta: float) -> void:
	queue_redraw()
	for wave in waves_array:
		#print(wave.lifetime)
		wave.lifetime += get_physics_process_delta_time()
		if wave.lifetime >= WAVE_LIFETIME:
			wave.queue_free()
			waves_array.erase(wave)


func _on_beat() -> void:
	#print(self)
	var new_wave := Wave.new()
	waves_array.append(new_wave)
	
	
	return
