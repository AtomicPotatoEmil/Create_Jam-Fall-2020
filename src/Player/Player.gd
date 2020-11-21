extends KinematicBody2D

var speed = 200
var velocity = Vector2()

var animation_state
var current_animation
var previous_animation

func _ready():
	animation_state = $AnimationTree.get("parameters/playback")
	current_animation = "idle_down"
	previous_animation = "idle down"
	animation_state.start("idle_down")
	pass

func _process(delta):
	get_input(delta)
	move_and_slide(velocity)
	pass

func get_input(dt):
	velocity = Vector2()
	
	if Input.is_action_pressed("right"):
		velocity.x += 1 * dt
		previous_animation = current_animation
		current_animation = "walk_right"
		animation_state.travel("walk_right")
	if Input.is_action_pressed("left"):
		velocity.x -= 1 * dt
		previous_animation = current_animation
		current_animation = "walk_left"
		animation_state.travel("walk_left")
	if Input.is_action_pressed("down"):
		velocity.y += 1 * dt
		previous_animation = current_animation
		current_animation = "walk_down"
		animation_state.travel("walk_down")
	if Input.is_action_pressed("up"):
		velocity.y -= 1 * dt
		previous_animation = current_animation
		current_animation = "walk_up"
		animation_state.travel("walk_up") 
	
	if velocity.length() == 0 and previous_animation == "walk_right":
		animation_state.travel("idle_right")
	if velocity.length() == 0 and previous_animation == "walk_left":
		animation_state.travel("idle_left")
	if velocity.length() == 0 and previous_animation == "walk_up":
		animation_state.travel("idle_up")
	if velocity.length() == 0 and (previous_animation == "idle_down" or previous_animation == "walk_down"):
		animation_state.travel("idle_down")
	
	velocity = velocity.normalized() * speed
	pass
