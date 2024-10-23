extends Marker2D

# Creates a blank variable to link to the pipe scene.
@export var pipe_scene : PackedScene

# Creates a blank variable to store the size of the viewport.
var viewport : Vector2


# Gets the size of the viewport when the scene loads.
func _ready():
	viewport = get_viewport_rect().size


# Spawns pipes on a random y position using the viewport size.
func _spawn_pipe():
	var pipe = pipe_scene.instantiate() 
	pipe.position.x = position.x
	pipe.global_position.y = randf_range(250, viewport.y - 250)
	call_deferred("add_sibling", pipe)
