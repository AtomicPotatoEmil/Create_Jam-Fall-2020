extends AnimatedSprite

signal salt_picked

func _process(delta):
	if $RayCast2D.is_colliding():
		play("interact")
		if Input.is_action_just_pressed("interact"):
			emit_signal("salt_picked")
	else:
		play("default")
