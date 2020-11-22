extends YSort

var drinking = true
signal vampire_flee

func _process(delta):
	if drinking:
		$body.play("default")
		$arms.play("default")


func _on_SmellRadius_area_entered(area):
	if area.is_in_group("garlic"):
		drinking = false
		$AnimationPlayer.play("flee")
	pass # Replace with function body.





func _on_AnimationPlayer_animation_finished(flee):
	emit_signal("vampire_flee")
	queue_free()
	pass # Replace with function body.
