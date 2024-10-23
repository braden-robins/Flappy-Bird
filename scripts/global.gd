extends Node

# Tracks the high score.
var high_score = 0

# Creates a path for persistent data storage.
var save_path = "user://data.save"

# Manages the player's ready state.
var player_ready = false


# Loads the score when the game is opened.
func _ready():
	_load_score()


# Saves the player's high score.
func _save_score():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(high_score)


# Loads the player's high score, or sets it to a default if the data file is missing.
func _load_score():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		high_score = file.get_var()
	else:
		high_score = 0
