extends CharacterBody2D

var spawnRectPadding = 50

func _process(delta):
	var screenSize = get_viewport_rect()
	var spawnRect = Rect2(
		Vector2(
			0 - spawnRectPadding,
			0 - spawnRectPadding,
		),
		Vector2(
			get_viewport_rect().size.x + spawnRectPadding,
			get_viewport_rect().size.y + spawnRectPadding,
		),
	)
	
	position = getRandomPoint(spawnRect, screenSize)
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal()) * 0.75

func getRandomPoint(insideRect: Rect2, outsideRect: Rect2):
	while true:
		var point = Vector2(
			randf_range(0.0 - spawnRectPadding, insideRect.size.x),
			randf_range(0.0 - spawnRectPadding, insideRect.size.y),
		)
		if insideRect.has_point(point) and not outsideRect.has_point(point):
			return point
