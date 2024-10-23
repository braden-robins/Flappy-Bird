extends Area2D


# Deletes pipes once they go past the left side of the screen.
func _cull_objects(area):
	if area.is_in_group("score"):
		area.call_deferred("queue_free")

