extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_up():
	get_tree().paused = not get_tree().paused
	get_node("../PauseMenu").visible = not get_node("../PauseMenu").visible
