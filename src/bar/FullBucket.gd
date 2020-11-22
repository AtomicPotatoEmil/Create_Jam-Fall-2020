extends Area2D

var drops_to_full = 10
var drops = 0

signal full_bucket_picked


func _process(delta):
	if drops < drops_to_full:
		$AnimatedSprite.play("default")
	else:
		if $RayCast2D.is_colliding():
			$AnimatedSprite.play("inter_bucket_full")
			if Input.is_action_just_pressed("interact"):
				emit_signal("full_bucket_picked")
				queue_free()
		else:
			$AnimatedSprite.play("bucket_full")
	pass


func _on_FullBucket_area_entered(area):
	if area.is_in_group("drop"):
		drops += 1
	pass # Replace with function body.
