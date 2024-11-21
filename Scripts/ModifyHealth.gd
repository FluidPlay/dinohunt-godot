extends Area2D

# Variables for health modification and destruction behavior
@export var destroy_when_activated : bool = false
@export var health_change : int = -1

# This function is called when the Area2D detects a collision
func _on_body_entered(body : Node) -> void:
	#TODO: Change to the 'connect signal' workflow
	
	# Check if the body that collided has a HealthSystem script attached
	if not body.has_method("modify_health"):
		pass

	var health_script = body.get_script()
	
	if health_script == null:
		pass

	# Modify health if the HealthSystem script exists
	health_script.modify_health(health_change)

	# Optionally destroy this object after it activates
	if destroy_when_activated:
		queue_free()  # Equivalent to Destroy(gameObject) in Unity
