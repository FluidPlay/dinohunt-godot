extends CharacterBody2D

# These are the forces that will push the object every frame
# Don't forget they can be negative too!
@export var direction : Vector2 = Vector2(1, 0)

@export var kinematic: bool = true

# Is the push relative or absolute to the world?
@export var relative_to_rotation : bool = false

# Called every physics frame
func _physics_process(_delta):
	if kinematic:
		velocity = direction * 2.0	
	if relative_to_rotation:
		pass
		#apply_impulse(Vector2(), direction * 2.0)  # Apply force relative to rotation
	else:
		pass
		#apply_force(direction * 2.0)  # Apply force in world space
	move_and_slide()

# Draw an arrow to show the direction in which the object will move
func _draw():
	var extra_angle : float = rotation if relative_to_rotation else 0.0
	#draw_move_arrow(position, direction, extra_angle)
#
## Custom function to draw the arrow (you would need to implement it)
#func draw_move_arrow(position: Vector2, direction: Vector2, extra_angle: float):
	## Implement drawing functionality here (e.g., using draw_line or draw_polygon)
	## This function draws the arrow indicating the movement direction, similar to OnDrawGizmosSelected
	#pass
