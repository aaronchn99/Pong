extends RigidBody2D

@export var start_speed = 700
@export var max_speed = 900
var original_pos : Vector2
var velocity : Vector2

var Rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	original_pos = position
	reset(1)	# Aim at player 1 first

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collide_info = move_and_collide(velocity * delta)
	var collide_sound = get_node("CollideSound")
	if collide_info:
		var Collider = collide_info.get_collider()
		if Collider.get_collision_layer() == 2: # Floor/Ceiling
			velocity = velocity.bounce(collide_info.get_normal())
			collide_sound.set_pitch_scale(1)
		else:	# Paddles
			var speed = velocity.length()
			var direction = (position - Collider.position).normalized()
			# Accelerate a bit per paddle bounce up to max_speed
			if speed < max_speed:
				speed += 10
			velocity = speed * direction
			collide_sound.set_pitch_scale(2)
		collide_sound.play()
	rotation = 0	# Prevent rotation due to sandwiching

# Moves ball back to starting position
# player (int) - The player to pass the ball to [1-2]
func reset(player : int):
	position = original_pos
	# Start 45deg from down, random chance to 135deg, reverse if p2
	velocity = start_speed * Vector2.DOWN.rotated(PI*(0.5+Rng.randi_range(0, 1))/2)
	if player == 2: velocity *= -1
	var collide_sound = get_node("CollideSound")
	collide_sound.set_pitch_scale(3)
	collide_sound.play()
