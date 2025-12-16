extends CharacterBody2D

var maxspeed = 420
var acceleration = 40
var turnRate = 5

func _process(delta):
	# ROTATE TO FACE CURSOR
	var rotationTarget = (get_global_mouse_position() - global_position).angle()
	rotation = lerp_angle(rotation, rotationTarget, 6 * delta)
	
	# A D STRAFING
	var strafeDirection = Input.get_axis("shipLeft", "shipRight")
	if strafeDirection:
		velocity.x += acceleration * strafeDirection
	
	# W S STRAFING
	var moveDirection = Input.get_axis("shipUp", "shipDown")
	if moveDirection:
		velocity.y += acceleration * moveDirection
	
	# SCREEN WRAPPING
	var screenSize = Vector2(get_viewport().size)
	if position.x > screenSize.x:
		position.x = 0
	elif position.x < 0:
		position.x = screenSize.x
	if position.y > screenSize.y:
		position.y = 0
	elif position.y < 0:
		position.y = screenSize.y
	
	# ~ move and slide ~                                                        <3
	velocity = velocity.limit_length(maxspeed)
	move_and_slide()
	
