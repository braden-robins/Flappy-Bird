extends Control

# Blank variable to link to the pipe spawner node using the inspector.
@export var spawner : Node

# Creates a link to the globle variable script
@onready var global = get_node("/root/Global")


# Displays the high score on the main menu when it's loaded.
func _ready():
	$canvas/high_score.text = "High score: " + str(global.high_score)


# Change to the main scene when the player selects play.
func _play_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://scenes/level.tscn")


# Quits the game completely when the player selects quit.
func _quit():
	get_tree().quit()


# Spawns pipes for the menu visuals.
func _menu_pipes(area):
	if area.is_in_group("score"):
		spawner._spawn_pipe()
