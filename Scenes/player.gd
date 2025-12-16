extends CharacterBody2D

var maxspeed = 420
var acceleration = 40
var turnRate = 5

func _process(delta):
	var rotationTarget = (get_global_mouse_position() - global_position).angle()
	rotation = lerp_angle(rotation, rotationTarget, turnRate * delta)
	
	var strafeDirection = Input.get_axis("shipLeft", "shipRight")
	if strafeDirection:
		velocity.x += acceleration * strafeDirection
	
	var moveDirection = Input.get_axis("shipUp", "shipDown")
	if moveDirection:
		velocity.y += acceleration * moveDirection
	
	velocity = velocity.limit_length(maxspeed)
	print(velocity)
	move_and_slide()
