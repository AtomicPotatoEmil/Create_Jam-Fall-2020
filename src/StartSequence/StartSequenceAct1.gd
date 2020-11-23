extends Node2D

func _ready():
	$press_text.hide()
	$main_anim.play("fade_in")

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene("res://StartSequence/StartSequenceAct2.tscn")
		pass
func _on_main_anim_animation_finished(anim_name):
	$press_text.show()
	$press_anim.play("fade_in_out")
	pass # Replace with function body.
