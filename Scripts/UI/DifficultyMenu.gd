extends Control

var game_scene = preload("res://Game.tscn")

@export var difficulty_config = {
	'Easy': {
		'Paddle2' : {
			'ai_type': 2,
			'UPDATE_INTERVAL': 10,
		}
	},
	'Normal': {
		'Paddle2' : {
			'ai_type': 3,
			'CORRUPT_CHANCE': 0.95,
		}
	},
	'Hard': {
		'Paddle2' : {
			'ai_type': 1,
		}
	}
}

func _go_back():
	get_node('../FirstMenu').visible = true
	visible = false


func _play_game(difficulty : String):
	$/root/Main/MainMenu.visible = false
	$/root/Main.add_child(game_scene.instantiate())
	
	var config = difficulty_config[difficulty]
	for obj_name in config:
		var obj = $/root/Main/Game.get_node(obj_name)
		for prop in config[obj_name]:
			obj[prop] = config[obj_name][prop]
