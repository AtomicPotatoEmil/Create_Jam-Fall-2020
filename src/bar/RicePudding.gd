extends AnimatedSprite

signal salted
onready var ray = $VerticalRay
var interactable = true

func _process(delta):
	if interactable:
		if ray.is_colliding():
			play("interact")
			if Input.is_action_just_pressed("interact"):
				emit_signal("salted")
		else:
			play("default")
	else:
		play("default")
	pass
