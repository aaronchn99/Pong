extends StaticBody2D

@export var velocity = Vector2(-500, -100)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collide_info = move_and_collide(velocity * delta)
	if collide_info:
		velocity = velocity.bounce(collide_info.get_normal())
