extends Control


# Hides the game over screen when the level scene is loaded.
func _ready():
	hide()


# Runs continously, delta is not needed
func _process(_delta):
	# Allows replay with spacebar instead of needing to click the button.
	if visible and Input.is_action_just_pressed("ui_accept"):
		_replay()


# Displays the final scores, with parameters fed through from the player.
func _game_over(score, high_score):
	$final_score.text = "Score: " + str(score)
	$high_score.text = "High score: " + str(high_score)
	show()


# Allows the game to replay.
func _replay():
	get_tree().paused = false
	get_tree().call_deferred("reload_current_scene")


# Quits the game back to the main menu.
func _quit():
	get_tree().paused = false
	get_tree().call_deferred("change_scene_to_file", "res://scenes/main_menu.tscn")
