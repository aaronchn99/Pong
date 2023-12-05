extends Node2D

@export var MAX_SCORE = 21

var p1_score = 0
var p2_score = 0
# Score setter, emits update signal
func set_score(player : int, score : int):
	if player == 1: p1_score = score
	else: p2_score = score
	emit_signal('property_list_changed')
func add_score(player : int, points : int):
	var old_score = p1_score if player == 1 else p2_score
	set_score(player, old_score + points)

func _on_paddle1_miss(body : Node2D):
	print('Paddle 1 has missed :(')
	add_score(2, 1)
	print(p2_score)
	respawn_ball(1)
	check_game_over()
	
func _on_paddle2_miss(body : Node2D):
	print('Paddle 2 has missed :(')
	add_score(1, 1)
	print(p1_score)
	respawn_ball(2)
	check_game_over()

func respawn_ball(player : int):
	var Ball = get_node("Ball")
	Ball.reset(player)

func check_game_over():
	if p1_score < MAX_SCORE and p2_score < MAX_SCORE:
		return
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
	get_node("GameOver/WhoWon").text = "P%s is the winner" % (1 if p1_score == MAX_SCORE else 2)
	get_node("GameOver").visible = true
	get_node("Pause").visible = false

func restart_game():
	$GameOver.visible = false
	$Pause.visible = true
	$Pause/PauseMenu.visible = false
	$Countdown.visible = true
	$Countdown/Timer.start()
	set_score(1, 0)
	set_score(2, 0)
	respawn_ball(1)

func end_game():
	get_tree().paused = false
	get_tree().reload_current_scene()
