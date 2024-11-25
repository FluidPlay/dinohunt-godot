extends Node

# Health variables
@export var health : int = 3
var max_health : int = 3
var player_number : int = -1

# Reference to GameManager
@onready var game_manager: Node = %GameManager

signal on_try_modify_health

func _ready():
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
	# Avoid exceeding max health
	if health + amount > max_health:
		amount = max_health - health

	health += amount
	print("New Health: "+str(health))
	
	# Update the UI if needed
	if game_manager != null and player_number != -1:
		#game_manager.set_health(health, player_number)
		game_manager.on_set_health.emit(health, player_number)
	
	# If health is zero or below, destroy the player
	if health <= 0:
		get_parent().queue_free()  # Equivalent to Destroy(gameObject) in Unity
		#TODO: Load scene after delay
