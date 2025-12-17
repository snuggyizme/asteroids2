extends Node

func bounce(pos):
	var screenSize = Vector2(get_viewport().size)
	pos = Vector2(
		pos.clampf(0, screenSize.x).x,
		pos.clampf(0, screenSize.y).y,
	)
	var vel: Vector2
	if pos.x >= screenSize.x or pos.x <= 0:
		vel.x *= -0.75
	if pos.y >= screenSize.y or pos.y <= 0:
		vel.y *= -0.75
	
	return [pos, vel]
