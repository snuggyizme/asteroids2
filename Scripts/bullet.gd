extends Area2D

var speed = 400
var screenPadding = 20

func _process(delta):
	position += Vector2.UP.rotated(rotation) * speed * delta
	
	var screenRect = Rect2(Vector2.ZERO - Vector2(-screenPadding, -screenPadding), get_viewport().size)
	if not screenRect.has_point(position):
		print("pfshhh")
		queue_free()
