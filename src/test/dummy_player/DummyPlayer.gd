extends KinematicBody2D

var speed = 200
var velocity = Vector2()

func _process(delta):
	get_input(delta)
	move_and_slide(velocity)
	pass

func get_input(dt):
	velocity = Vector2()
	
	if Input.is_action_pressed("right"):
		velocity.x += 1 * dt
	if Input.is_action_pressed("left"):
		velocity.x -= 1 * dt
	if Input.is_action_pressed("down"):
		velocity.y += 1 * dt
	if Input.is_action_pressed("up"):
		velocity.y -= 1 * dt 
	
	velocity = velocity.normalized() * speed
	pass
