extends KinematicBody2D

var speed = 200
var velocity = Vector2()

var animation_state
var current_animation
var previous_animation

var has_swapper = false
var has_bucket = false
var has_feather = false

func _ready():
	animation_state = $AnimationTree.get("parameters/playback")
	current_animation = "idle_down"
	previous_animation = "idle down"
	animation_state.start("idle_down")
	
	pass

func _process(delta):
	if $GarlicStink.emitting:
		$StinkRadius/CollisionShape2D.disabled = false
	get_input(delta)
	move_and_slide(velocity)

func get_input(dt):
	velocity = Vector2()
	
	if has_feather:
		if Input.is_action_just_pressed("tickle") and (previous_animation == "idle_right" or previous_animation == "walk_right"):
			animation_state.travel("tickle_right")
			return
		if Input.is_action_just_pressed("tickle") and (previous_animation == "idle_left" or previous_animation == "walk_left"):
			animation_state.travel("tickle_left")
			return
		if Input.is_action_just_pressed("tickle") and (previous_animation == "idle_up" or previous_animation == "walk_up"):
			animation_state.travel("tickle_up")
			return
		if Input.is_action_just_pressed("tickle") and (previous_animation == "idle_down" or previous_animation == "walk_down"):
			animation_state.travel("tickle_down")
			return
	
	if has_bucket:
		if Input.is_action_just_pressed("splash") and (previous_animation == "idle_right" or previous_animation == "walk_right"):
			animation_state.travel("splash_right")
			return
		if Input.is_action_just_pressed("splash") and (previous_animation == "idle_left" or previous_animation == "walk_left"):
			animation_state.travel("splash_left")
			return
		if Input.is_action_just_pressed("splash") and (previous_animation == "idle_down" or previous_animation == "walk_down"):
			animation_state.travel("splash_down")
			return
		if Input.is_action_just_pressed("splash") and (previous_animation == "idle_up" or previous_animation == "walk_up"):
			animation_state.travel("splash_up")
			return
	
	if has_swapper:
		if Input.is_action_just_pressed("flyswapper") and (previous_animation == "idle_down" or previous_animation == "walk_down"):
			animation_state.travel("flyswapper_down")
			return
		if Input.is_action_just_pressed("flyswapper") and (previous_animation == "idle_right" or previous_animation == "walk_right"):
			animation_state.travel("flyswapper_right")
			return
		if Input.is_action_just_pressed("flyswapper") and (previous_animation == "idle_left" or previous_animation == "walk_left"):
			animation_state.travel("flyswapper_left")
			return
		if Input.is_action_just_pressed("flyswapper") and (previous_animation == "idle_up" or previous_animation == "walk_up"):
			animation_state.travel("flyswapper_up")
			return
	
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



func _on_Bar_swapper_gained():
	has_swapper = true
	pass # Replace with function body.


func _on_Bar_bucket_gained():
	has_bucket = true
	print("has bucket")
	pass # Replace with function body.


func _on_Bar_feather_gained():
	has_feather = true
	pass # Replace with function body.
