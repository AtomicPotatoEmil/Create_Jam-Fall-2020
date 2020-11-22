extends AnimatedSprite

signal swapper_picked

func _process(delta):
	if $RayCast2D.is_colliding():
		play("interact")
		if Input.is_action_just_pressed("interact"):
			emit_signal("swapper_picked")
			queue_free()
	else:
		play("default")
	pass
