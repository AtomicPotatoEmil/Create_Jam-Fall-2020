extends YSort

signal dead

func _on_upper_animation_finished():
	$buttom.play("melt")
	$upper.queue_free()


func _on_buttom_animation_finished():
	queue_free()
	pass # Replace with function body.


func _on_Hurtbox_area_entered(area):
	if area.is_in_group("water"):
		emit_signal("dead")
		$upper.play("melt")
	pass # Replace with function body.
