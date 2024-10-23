extends StaticBody2D

# Blank variable to store the viewport size.
var viewport : Vector2

# Used to prevent a pipe from scoring twice.
var passed = false

# Used to set the random position on only the first pipe.
@export var first_pipe = false

# Connects to the global variable script.
@onready var global = get_node("/root/Global")


# Sets the first pipe to a random position on the y axis.
func _ready():
	if first_pipe:
		viewport = get_viewport_rect().size
		global_position.y = randf_range(250, viewport.y - 250)


# Moves the pipe to the left every frame, delta is not used.
func _process(_delta):
	if global.player_ready or get_tree().current_scene.name == "main_menu":
		position.x -= 5
