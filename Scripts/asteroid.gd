extends CharacterBody2D

var spawnRectPadding = 50
var spriteRotation
var speed
var heading

func _enter_tree():
	spriteRotation = randi_range(1, 4)
	speed = randf_range(15, 30)
	heading = randi_range(0, 360)
	
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
	
	rotation_degrees = heading
	velocity = Vector2.ZERO.rotated(deg_to_rad(heading)) * speed
	position = getRandomPoint(spawnRect, screenSize)

func _process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal()) * 0.75

func getRandomPoint(insideRect: Rect2, outsideRect: Rect2):
	while true:
		var point = Vector2(
			randf_range(insideRect.position.x, insideRect.end.x),
			randf_range(insideRect.position.y, insideRect.end.y),
		)
		if insideRect.has_point(point) and not outsideRect.has_point(point):
			return point
