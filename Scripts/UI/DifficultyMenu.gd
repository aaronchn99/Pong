extends Control

var game_scene = preload("res://Game.tscn")

@export var difficulty_config = {
	'Easy': {
		'Paddle2' : {
			'ai_type': 3,
			'CORRUPT_CHANCE': 0.95,
		}
	},
	'Normal': {
		'Paddle2' : {
			'ai_type': 1,
		}
	},
	'Hard': {
		'Paddle2' : {
			'ai_type': 6,
			'speed': 550,
		}
	},
	'Impossible': {
		'Paddle2' : {
			'ai_type': 5,
		}
	},
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

var cheat_code = ['ui_up', 'ui_up', 'ui_down', 'ui_down', 'ui_left', 'ui_right', 'ui_left', 'ui_right',]
var i = 0
var timeout = 1
func _process(delta):
	if timeout > 0: timeout -= delta
	else: i = 0
	
	if not $ImpossibleButton.visible and Input.is_action_just_released(cheat_code[i]):
		i += 1
		timeout = 1
		if i >= len(cheat_code):
			$ImpossibleButton.visible = true
