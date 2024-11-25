extends Area2D

# Variables for health modification and destruction behavior
@export var destroy_when_activated : bool = true
@export var health_change : int = -1

# This function is called when the Area2D detects a collision
func _on_body_entered(otherguy: Node2D) -> void:
	# print("other: "+otherguy.name)
	if not otherguy.is_in_group("Player"):
		print("not a player!")
		pass
	
	otherguy.get_node("HealthSystem").on_try_modify_health.emit(health_change)

	## Old Godot v3 way:		
	# otherguy.get_node("HealthSystem").emit_signal("on_try_modify_health", health_change)
	
	
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

	# Optionally destroy this object after it activates
	if destroy_when_activated:
		get_parent().queue_free()  # Equivalent to Destroy(gameObject) in Unity
			
