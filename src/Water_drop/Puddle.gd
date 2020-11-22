extends Area2D

signal bucket_placed

onready var ray = $RayCast2D
onready var animation = $AnimatedSprite
var interactable = true

func _process(delta):
	
	if interactable:
		if ray.is_colliding():
			animation.play("interact")
			if Input.is_action_just_pressed("interact"):
				emit_signal("bucket_placed")
		else:
			animation.play("default")
	else:
		animation.play("default")
	pass


func _on_Bar_bucket_placed():
	interactable = false
	pass # Replace with function body.
