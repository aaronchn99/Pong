extends Control

func _ready():
	get_tree().paused = true

func _process(delta):
	if int($CountdownLabel.text) != int($Timer.time_left+1):
		$Timer/TimerBeep.set_pitch_scale(1)
		$Timer/TimerBeep.play()
	$CountdownLabel.text = str(int($Timer.time_left+1))

func _on_timer_timeout():
	$Timer/TimerBeep.set_pitch_scale(3)
	$Timer/TimerBeep.play()
	visible = false
	get_tree().paused = false
