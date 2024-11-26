extends Area2D

# Variables for health modification and destruction behavior
@export var destroy_when_activated : bool = true
@export var health_change : int = -1
# That one is optional, we use get_node_or_null to prevent warnings when null
@onready var audio_stream_player := get_node_or_null("AudioStreamPlayer2D") as AudioStreamPlayer2D

var was_collected:bool = false

## Connect Signal through code instead of using the 'Node' panel
func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

# This function is called when the Area2D detects a collision
func _on_body_entered(otherguy: Node2D) -> void:
	# If it didn't collide with a player, do nothing
	if not otherguy.is_in_group("Player") or was_collected:
		pass
	
	was_collected = true
	
	otherguy.get_node("HealthSystem").on_try_modify_health.emit(health_change)
	## Old Godot v3 way:		
	# otherguy.get_node("HealthSystem").emit_signal("on_try_modify_health", health_change)
	
	# Optionally destroys this object ('s parent) after it's done
	if destroy_when_activated:
		var root = get_parent()
		root.hide()
			
		if audio_stream_player != null:
			audio_stream_player.play()
			
		await audio_stream_player.finished	

		# Destroy this object ('s parent) after it's collected
		root.queue_free()
	
	## Check if the body that collided has a HealthSystem script attached
	#if not otherguy.get_node("HealthSystem").has_method("modify_health"):
		#print("didnt find 'modify_health'")
		#pass
#
	## Directly access and use method (not recommended, breaks encapsulation)
	#var health_script = otherguy.get_node("HealthSystem").get_script()
	#if health_script == null:
	#	pass
#	#health_script.modify_health(health_change)


			
			
