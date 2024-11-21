extends Node

# Health variables
@export var health : int = 3
var max_health : int = 3
var player_number : int = -1

# Reference to the UI script
var ui : Node

func _ready():
	# Find the UI in the scene
	ui = get_node("/root/UIScript")  # Adjust the path if necessary

	# Set the player number based on the node name (could use groups)
	match self.name:
		"P1Health":
			player_number = 0
		"P2Health":
			player_number = 1
		_:
			player_number = -1
	
	# Notify the UI about the initial health value if a UI exists and it's a player
	if ui != null and player_number != -1:
		ui.set_health(health, player_number)
	
	max_health = health  # Record max health

# Modify the player's health and update the UI
func modify_health(amount : int):
	# Avoid exceeding max health
	if health + amount > max_health:
		amount = max_health - health

	health += amount
	print("New Health: "+str(health))
	
	# Update the UI if needed
	if ui != null and player_number != -1:
		ui.change_health(amount, player_number)
	
	# If health is zero or below, destroy the player
	if health <= 0:
		get_parent().queue_free()  # Equivalent to Destroy(gameObject) in Unity
		#TODO: Load scene after delay
