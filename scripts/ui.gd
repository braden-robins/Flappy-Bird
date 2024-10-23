extends CanvasLayer


# Updates the score when the player passes through a pipe.
func _update_score(score):
	$score.text = "Score: " + str(score)


# Runs the game over function when the player dies.
func _end_game(score, high_score):
	$control._game_over(score, high_score)
	$score.hide()
