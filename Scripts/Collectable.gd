extends Area2D

# Variables
@export var points_to_add : int = 1
@onready var game_manager: Node = %GameManager
#@onready var audio_stream_player = $AudioStreamPlayer2D                                                                                                                                                          
@onready var audio_stream_player := get_node_or_null("AudioStreamPlayer2D") as AudioStreamPlayer2D
var player_number = -1
var was_collected:bool = false

#func _on_ready() -> void:
	#audio_stream_player = $AudioStreamPlayer2D
	
# This function is called when the Area2D detects a collision
func _on_body_entered(otherguy: Node2D) -> void:
	if not otherguy.is_in_group("Player") or was_collected:
		pass
		
	was_collected = true
		
	match otherguy.name:
		"Player":
			player_number = 0
		"Player1":
			player_number = 0
		"Player2":
			player_number = 1
		_:
			player_number = -1		
	
	# otherguy.get_node("HealthSystem").on_try_modify_health.emit(health_change)
	if game_manager != null and player_number != -1:
		game_manager.on_add_score.emit(points_to_add, player_number)

	var root = get_parent()
	root.hide()
		
	if audio_stream_player != null:
		print("trying to play audio stream")
		audio_stream_player.play()
	else:
		print("AudioStreamPlayer2D not found")
		
	await audio_stream_player.finished	

	# Destroy this object ('s parent) after it's collected
	root.queue_free()
			
