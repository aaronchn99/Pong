extends Node2D

var p1_score = 0
var p2_score = 0

func _on_paddle1_miss(body : Node2D):
	print('Paddle 1 has missed :(')
	p2_score += 1
	print(p2_score)
	respawn_ball()
	
func _on_paddle2_miss(body : Node2D):
	print('Paddle 2 has missed :(')
	p1_score += 1
	print(p1_score)
	respawn_ball()

func respawn_ball():
	var Ball = get_node("Ball")
	Ball.reset()
