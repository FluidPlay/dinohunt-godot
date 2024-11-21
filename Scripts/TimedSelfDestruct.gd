extends Node

var timer : Timer
@export var time_to_destroy : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = time_to_destroy
	timer.autostart = true
	timer.one_shot = true
	add_child(timer)
	await timer.timeout
	queue_free()
