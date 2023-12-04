extends Node2D

@export var MAX_SCORE = 21

var p1_score = 0
var p2_score = 0

func _on_paddle1_miss(body : Node2D):
	print('Paddle 1 has missed :(')
	p2_score += 1
	print(p2_score)
	respawn_ball(1)
	
func _on_paddle2_miss(body : Node2D):
	print('Paddle 2 has missed :(')
	p1_score += 1
	print(p1_score)
	respawn_ball(2)

func respawn_ball(player : int):
	var Ball = get_node("Ball")
	Ball.reset(player)

func _process(delta):
	if p1_score == MAX_SCORE or p2_score == MAX_SCORE:
		var sound = get_node('Ball/CollideSound')
		sound.set_pitch_scale(1)
		sound.set_volume_db(1)
		sound.play()
		while sound.is_playing(): continue
		sound.play()
		while sound.is_playing(): continue
		sound.set_pitch_scale(1)
		sound.set_volume_db(0)
		get_tree().paused = true
