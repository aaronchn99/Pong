extends RigidBody2D

@export var start_velocity = Vector2(-500, -100)
var original_pos : Vector2
var velocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	original_pos = position
	velocity = start_velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collide_info = move_and_collide(velocity * delta)
	if collide_info:
		var Collider = collide_info.get_collider()
		if Collider.get_collision_layer() == 2:
			velocity = velocity.bounce(collide_info.get_normal())
		else:
			var speed = velocity.length()
			var direction = (position - Collider.position).normalized()
			velocity = speed * direction

# Moves ball back to starting position
func reset():
	position = original_pos
	velocity = start_velocity
