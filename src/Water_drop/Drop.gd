extends Area2D

var speed = 200

func _ready():
	$AnimationPlayer.play("default")

func _physics_process(delta):
	position.y += speed * delta


func _on_Drop_area_entered(area):
	if area.is_in_group("puddle"):
		speed = 0
		$AnimationPlayer.play("splash")
	if area.is_in_group("bucket"):
		queue_free()
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(splash):
	queue_free()
	pass # Replace with function body.
