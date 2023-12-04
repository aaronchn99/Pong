extends StaticBody2D

@export var speed : int
@export var is_human : bool

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

var STARTCD = 20
var countdown = 0
var dir = 0
func cpu_control():
	countdown -= 1
	if countdown <= 0:
		dir = Rng.randi_range(-1, 1)
		countdown = STARTCD
	return dir
	
