extends Node2D
class_name Deck

@onready var timer:Timer = $Timer

signal deal

enum STATES { INACTIVE, WAITING, RELEASE}
var activeState: STATES =  STATES.INACTIVE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
#	if activeState == STATES.INACTIVE:
#		if event.is_pressed():
#			activeState = STATES.WAITING
#			print("PRESSED")
#	elif activeState == STATES.WAITING:
#	elif activeState == 
	if event is InputEventMouseButton && event.is_pressed():
		print("PRESSED")
		if activeState == STATES.INACTIVE:
			activeState = STATES.WAITING
		elif activeState == STATES.WAITING:
			deal.emit()
	elif event is InputEventMouseButton && event.is_released():
		print("RELEASED")
		if activeState == STATES.WAITING:
			timer.start()


func _on_timer_timeout():
	activeState = STATES.INACTIVE
