extends Node

signal beat

var bpm : float = 130.0
@onready var sec_delta : float = 60.0/bpm
	
var elapsed_beat : float = 0.0
func _process(delta: float) -> void:
	elapsed_beat += delta
	if elapsed_beat >= sec_delta:
		on_beat_timer_timeout()
		elapsed_beat = 0.0
	
func on_beat_timer_timeout() -> void:
	beat.emit()
