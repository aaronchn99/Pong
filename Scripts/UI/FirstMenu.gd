extends Control


func _quit_game():
	get_tree().quit()


func _play_game():
	get_node('../DifficultyMenu').visible = true
	visible = false
