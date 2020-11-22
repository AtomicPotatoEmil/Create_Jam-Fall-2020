extends Area2D

var drops_until_full = 10
var drops = 0
var state = "empty"

signal empty_bucket_picked

func _process(delta):
	if state == "empty":
		$VerticalRay.enabled = true
		$HorizontalRay.enabled = false
		if $VerticalRay.is_colliding():
			$AnimatedSprite.play("inter_empty")
			if Input.is_action_just_pressed("interact"):
				emit_signal("empty_bucket_picked")
				queue_free()
		else:
			$AnimatedSprite.play("empty")

