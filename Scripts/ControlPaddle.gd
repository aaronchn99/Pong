extends StaticBody2D

@export var speed : int
@export var is_human : bool

enum AI_Type {RANDOM, FOLLOW, FOLLOW_STICKY, FOLLOW_CORRUPT, FOLLOW_CORRUPT_STICKY}
@export var ai_type : AI_Type

var Rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var motion = Vector2.DOWN * speed * delta;
	
	motion *= human_control() if is_human else cpu_control()
	
	if not test_move(transform, motion):
		position += motion

func human_control():
	if Input.is_action_pressed('ui_up'):
		return -1
	if Input.is_action_pressed('ui_down'):
		return 1
	return 0

@export var UPDATE_INTERVAL = 20
var countdown = 0
var dir = 0
func random_ai():
	countdown -= 1
	if countdown <= 0:
		dir = Rng.randi_range(-1, 1)
		countdown = UPDATE_INTERVAL
	return dir

# Follow ball
func follow_ai():
	var Ball = get_node("../Ball")
	return (Ball.position.y - position.y)/abs(Ball.position.y - position.y)

# Follow but with sticky controls (direction does not change for interval)
func follow_sticky():
	countdown -= 1
	if countdown <= 0:
		dir = follow_ai()
		countdown = UPDATE_INTERVAL
	return dir

# Follow with corruption (random chance of going opposite direction)
@export var CORRUPT_CHANCE = 0.8
func follow_corrupt():
	if Rng.randf() > CORRUPT_CHANCE:
		return follow_ai() * -1
	return follow_ai()

# Sticky follow with corruption
func follow_corrupt_sticky():
	countdown -= 1
	if countdown <= 0:
		dir = follow_corrupt()
		countdown = UPDATE_INTERVAL
	return dir

func cpu_control():
	if ai_type == AI_Type.RANDOM:
		return random_ai()
	elif ai_type == AI_Type.FOLLOW:
		return follow_ai()
	elif ai_type == AI_Type.FOLLOW_STICKY:
		return follow_sticky()
	elif ai_type == AI_Type.FOLLOW_CORRUPT:
		return follow_corrupt()
	elif ai_type == AI_Type.FOLLOW_CORRUPT_STICKY:
		return follow_corrupt_sticky()
	
