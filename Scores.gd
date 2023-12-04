extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Update points
func update_score():
	var Game = get_node("..")
	get_node("P1Score").text = str(Game.p1_score)
	get_node("P2Score").text = str(Game.p2_score)
