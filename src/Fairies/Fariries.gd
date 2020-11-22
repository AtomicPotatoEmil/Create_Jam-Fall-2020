extends Area2D

var is_alive = true
signal is_dead

func _process(delta):
	if is_alive:
		$AnimatedSprite.play("default")
	else:
		$AnimatedSprite.play("dead")


func _on_Fariries_area_entered(area):
	if area.is_in_group("swapper"):
		is_alive = false
		emit_signal("is_dead")
		$CollisionShape2D.disabled = true
	pass # Replace with function body.
