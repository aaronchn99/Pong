extends Control


func _quit_game():
	get_tree().quit()


func _play_game():
	get_node('../DifficultyMenu').visible = true
	visible = false

func _ready():
	if OS.get_name() == "Web":
			$QuitButton.visible = false
