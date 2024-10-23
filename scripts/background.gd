extends Node2D

# Creates blank variables to be filled in through the inspector menu.
@export var bg_1 : Node
@export var bg_2 : Node


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Moves the background layers to the left at different speeds.
	bg_1.global_position.x -= 50 * delta
	bg_2.global_position.x -= 150 * delta
	
	# Moves the backgrounds back to the default position when they reach the end
	if bg_1.global_position.x <= 0:
		bg_1.global_position.x = 540
		
	if bg_2.global_position.x <= 0:
		bg_2.global_position.x = 540
