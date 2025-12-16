extends CharacterBody2D

var maxspeed = 420
var acceleration = 40
var turnRate = 5
var recoil = 35

@onready var bulletScene = preload("res://Scenes/bullet.tscn")

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
	
	# BOUNCE
	var screenSize = Vector2(get_viewport().size)
	position = Vector2(
		position.clampf(0, screenSize.x).x,
		position.clampf(0, screenSize.y).y,
	)
	if position.x >= screenSize.x or position.x <= 0:
		velocity.x *= -0.75
	if position.y >= screenSize.y or position.y <= 0:
		velocity.y *= -0.75
	
	# ~ move and slide ~                                                        <3
	velocity = velocity.limit_length(maxspeed)
	move_and_slide()
	
func _input(event):
	if event.is_action_pressed("shipShoot"):
		# SHOOT
		var bullet = bulletScene.instantiate()
		bullet.position = position
		bullet.rotation = rotation + 90
		get_parent().add_child(bullet)
		
		# RECOIL
		velocity -= (get_global_mouse_position() - global_position).normalized() * recoil
		
