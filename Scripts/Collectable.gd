extends Area2D

# Variables
@export var points_to_add : int = 1
@onready var game_manager: Node = %GameManager
var player_number = -1

# This function is called when the Area2D detects a collision
func _on_body_entered(otherguy: Node2D) -> void:
	if not otherguy.is_in_group("Player"):
		print("Not player")
		pass
		
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

	# Destroy this object ('s parent) after it's collected
	get_parent().queue_free()
			
