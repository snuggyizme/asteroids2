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
	var bounceExport = GlobalTools.bounce(position)
	position = bounceExport[0]
	velocity = bounceExport[1]
	
	# ~ move and slide ~                                                        <3
	velocity = velocity.limit_length(maxspeed)
	move_and_slide()
	
func _input(event):
	if event.is_action_pressed("shipShoot"):
		# SHOOT
		while true:
			var bullet = bulletScene.instantiate()
			bullet.position = position
			bullet.rotation = rotation + 90
			get_parent().add_child(bullet)
			
			# RECOIL
			velocity -= (get_global_mouse_position() - global_position).normalized() * recoil
		
