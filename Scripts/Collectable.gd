extends Area2D

# Variables
@export var points_to_add : int = 1
var game_manager: Node
#@onready var collection_sound = $AudioStreamPlayer2D   

# That one is optional, we use get_node_or_null to prevent warnings when null                                                                                                                                                       
# get_node_or_null("AudioStreamPlayer2D") as AudioStreamPlayer2D
@export var collection_sound: AudioStreamPlayer2D
var player_number = -1
var was_collected:bool = false

## Connect Signal through code instead of using the 'Node' panel
func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	game_manager = get_tree().root.get_node("Root").get_node("GameManager")
	
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
		print("here")
		game_manager.on_add_score.emit(points_to_add, player_number)

	var root = get_parent()
	root.hide()
		
	if collection_sound != null:
		collection_sound.play()
		await collection_sound.finished	

	# Destroy this object ('s parent) after it's collected
	root.queue_free()
			
