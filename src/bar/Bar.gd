extends Node2D

onready var giant_animation = $YSort/Giant/AnimationPlayer
onready var beer_animation = $YSort/Beer

onready var witch_animation = $YSort/Witch/upper
onready var text = $YSort/Player/TextBubble
onready var talk_timer = $YSort/Player/TalkTimer

var has_salt = false
var has_bucket = false

var current_text = ""
var talking = false

signal swapper_gained
signal bucket_placed
signal bucket_gained
signal feather_gained

var feather_dropped = false

var vampire_gone = false

var creatures_in_bar = 5

func _ready():
	$YSort/Nisse.play("default")
	$LeakTimer.start()
	$Raven.hide()
	$YSort/AngryNisse.hide()
	
	$MouseRight.hide()
	$MouseRightLabel.hide()
	
	$Q.hide()
	$QLabel.hide()
	
	$MouseLeft.hide()
	$MouseLeftLabel.hide()

func _process(delta):
	if talking == true:
		text.show()
	else:
		text.hide()
		
	text.text = current_text
	
	if $YSort/Player.has_feather == false:
		if feather_dropped == false:
			$YSort/Feather.hide()
		else:
			$YSort/Feather.show()
	if $Time.hour >= 24:
		get_tree().change_scene("res://GameOver/GameOver.tscn") 
	
	if creatures_in_bar == 0:
		get_tree().change_scene("res://StartSequence/Victory.tscn")




func _on_RicePudding_salted():
	if has_salt == false:
		talking = true
		current_text = "There must be some \n way to make him stop eating"
		talk_timer.start()
	else:
		$YSort/RicePudding.interactable = false
		$YSort/Nisse.queue_free()
		$YSort/AngryNisse.show()
		$YSort/AngryNisse/AnimationPlayer.play("walking_out")
	pass 


func _on_TalkTimer_timeout():
	talking = false
	talk_timer.stop()
	pass 


func _on_Puddle_bucket_placed():
	if has_bucket == false:
		talking = true
		current_text = "The ceiling is leaking again..."
		talk_timer.start()
	elif has_bucket:
		var bucket = preload("res://bar/FullBucket.tscn")
		var b = bucket.instance()
		get_parent().add_child(b)
		b.position = $YSort/Puddle.global_position
		has_bucket == false
		emit_signal("bucket_placed")
		b.connect("full_bucket_picked", self, "_on_full_bucket_picked")
		
	pass 

func _on_full_bucket_picked():
	emit_signal("bucket_gained")
	$Q.show()
	$QLabel.show()



func _on_LeakTimer_timeout():
	var drop = preload("res://Water_drop/Drop.tscn")
	var d = drop.instance()
	get_parent().add_child(d)
	d.position = $LeakPosition.global_position
	pass # Replace with function body.


func _on_Flyswapper_swapper_picked():
	emit_signal("swapper_gained")
	talking = true
	current_text = "Not many flies aroud but might be usefull..."
	talk_timer.start()
	$MouseLeft.show()
	$MouseLeftLabel.show()
	pass # Replace with function body.


func _on_Bucket_empty_bucket_picked():
	has_bucket = true
	pass # Replace with function body.


func _on_Bar_bucket_placed():
	talking = true
	current_text = "Might be a while before it fills up..."
	talk_timer.start()
	pass 


func _on_Fariries_is_dead():
	talking = true
	current_text = "I.. I.. mistook them for flies.. \n yeah.. thats what I did..."
	talk_timer.start()
	creatures_in_bar -= 1
	print(creatures_in_bar)
	pass # Replace with function body.


func _on_Witch_dead():
	feather_dropped = true
	talking = true
	current_text = "Oh no I melted a quest! \n This is not gonna look good \n on my performance evaluation..."
	talk_timer.start()
	$Raven.show()
	$Raven/AnimationPlayer.play("move_raven")
	creatures_in_bar -= 1
	print(creatures_in_bar)
	pass # Replace with function body.


func _on_Feather_feather_picked():
	$MouseRight.show()
	$MouseRightLabel.show()
	emit_signal("feather_gained")
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	$Raven.queue_free()
	pass # Replace with function body.


func _on_footbox_area_entered(area):
	if area.is_in_group("tickle"):
		giant_animation.play("remove_foot")
		beer_animation.play("tip_over")
	pass # Replace with function body.


func _on_Salt_salt_picked():
	if vampire_gone:
		has_salt = true
		$YSort/Salt.queue_free()
	else:
		talking = true
		current_text = "I am not gonna risk being seasoned \n with that while the vampire is here..."
		talk_timer.start()


func _on_Garlic_garlic_picked():
	$YSort/Player/GarlicStink.emitting = true
	talking = true
	current_text = "Now why would I pick that up?"
	talk_timer.start()
	pass # Replace with function body.




func _on_Vampire_vampire_flee():
	vampire_gone = true
	talking = true
	current_text = "         Rude..."
	talk_timer.start()
	creatures_in_bar -= 1
	print(creatures_in_bar)
	pass # Replace with function body.


func _on_AngryNisse_AnimationPlayer_animation_finished(walking_out):
	$YSort/AngryNisse.queue_free()
	creatures_in_bar -= 1
	print(creatures_in_bar)
	pass # Replace with function body.


func _on_foot_animation_finished(anim_name):
	$YSort/Giant.queue_free()
	creatures_in_bar -= 1
	print(creatures_in_bar)
	pass # Replace with function body.
