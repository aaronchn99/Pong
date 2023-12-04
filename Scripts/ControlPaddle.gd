extends StaticBody2D

@export var speed : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var motion = Vector2.DOWN * speed * delta;
	if Input.is_action_pressed('ui_up'):
		motion *= -1
	elif Input.is_action_pressed('ui_down'):
		motion *= 1
	else:
		motion *= 0
	
	if not test_move(transform, motion):
		position += motion
	
