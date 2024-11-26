extends Node

# Health variables
@export var health : int = 3
var max_health : int = 3
var player_number : int = -1

# @onready var death_sound_stream := get_node_or_null("AudioStreamPlayer2D") as AudioStreamPlayer2D
@export var death_sound_stream : AudioStreamPlayer2D

var game_manager: Node

signal on_try_modify_health

func _ready():
	game_manager = get_tree().root.get_node("Root").get_node("GameManager")
	
	on_try_modify_health.connect(try_modify_health)
	
	# Set the player number based on the node name (could use groups)
	match get_parent().name:
		"Player":
			player_number = 0
		"Player1":
			player_number = 0
		"Player2":
			player_number = 1
		_:
			player_number = -1
	
	# Notify the UI about the initial health value if a UI exists and it's a player
	if game_manager != null and player_number != -1:
		game_manager.on_set_health.emit(health, player_number)
	
	max_health = health  # Set max_health to health initially

# Modify the player's health and update the UI
func try_modify_health(amount : int):

	health += amount
	
	# Avoid exceeding max health or going below zero
	health = clamp(health, 0, max_health)
	#print("New Health: "+str(health))
	

	# Update the Game Manager / UI if needed
	if game_manager != null and player_number != -1:
		#game_manager.set_health(health, player_number)
		game_manager.on_set_health.emit(health, player_number)	
	
	# If health is zero or below, destroy the player
	if health <= 0:
		var root = get_parent()
		root.hide()
			
		if death_sound_stream != null:
			# Assures the death_sound will play even with the paused game
			death_sound_stream.process_mode = PROCESS_MODE_ALWAYS
			death_sound_stream.play()
			await death_sound_stream.finished
			# Destroy this object ('s parent) after it's collected
			root.queue_free()
		else:
			root.queue_free()
