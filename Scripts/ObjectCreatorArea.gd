extends Area2D

# The object to spawn
@export var object_to_spawn : PackedScene

# Configure the spawning pattern
@export var spawn_interval : float = 1.0
@export var box_collider2d : CollisionShape2D
var timer : Timer

func _ready():
	#box_collider2d = $CollisionShape2D
	# Create a timer before actually spawning
	timer = Timer.new()
	timer.wait_time = spawn_interval
	# timer.autostart = true
	# timer.one_shot = true
	add_child(timer)
	await_spawn_object()

# Waits for spawn_interval seconds before spawning
func await_spawn_object():
	# await get_tree().create_timer(1.0).timeout
	timer.start()
	await timer.timeout
	spawn_object()
	# timer.connect("timeout", self, "_on_timeout")

# Actually spawn a new object
func spawn_object():
	# Get the box collider size (Assumes the collision shape is a RectangleShape2D)
	var size = box_collider2d.shape.extents

	# Generate random position within the box collider
	var random_x = randf_range(-size.x, size.x)
	var random_y = randf_range(-size.y, size.y)

	# Instantiate the object and set its position
	var new_object = object_to_spawn.instantiate()
	new_object.position = Vector2(random_x + position.x, random_y + position.y)

	# Add the new object as a child of the current node (or anywhere else you prefer)
	get_parent().add_child(new_object)
	
	# Rinse and repeat
	await_spawn_object()
