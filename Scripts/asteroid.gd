extends CharacterBody2D

func _process(delta):
	
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal()) * 0.75
