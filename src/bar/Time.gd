extends Label

var hour = 21
var minute = 00

func _ready():
	$Timer.start()

func _process(delta):
	text = "Hour: "+str(hour)+" Minute: "+str(minute)
	
	if minute >= 60:
		hour += 1
		minute = 0
	pass


func _on_Timer_timeout():
	minute += 1
	pass # Replace with function body.
