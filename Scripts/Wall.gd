extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_paddle_missed)

func _on_paddle_missed(body):
	print('Paddle 1 has missed :(')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print('Paddle 1 has missed :(')
