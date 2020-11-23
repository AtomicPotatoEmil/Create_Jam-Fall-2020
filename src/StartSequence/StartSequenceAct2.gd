extends Node2D

func _ready():
	$play.hide()
	$main_anim.play("fade_in")

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene("res://bar/Bar.tscn")

func _on_main_anim_animation_finished(anim_name):
	$play.show()
	$press_anim.play("fade_in_out")
	pass # Replace with function body.
