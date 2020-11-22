extends AnimatedSprite

signal feather_picked

onready var v_ray = $VerticalRay
onready var h_ray = $HorizontalRay


func _process(delta):
	if v_ray.is_colliding():
		if Input.is_action_just_pressed("interact"):
			emit_signal("feather_picked")
			queue_free()
		play("interact")
	elif h_ray.is_colliding():
		if Input.is_action_just_pressed("interact"):
			emit_signal("feather_picked")
			queue_free()
		play("interact")
	else:
		play("default")
	pass
