extends Node2D

@onready var notifyText: Label = $Notification/Label
var message: String = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	notifyText.text = message

func _on_animation_player_animation_finished(anim_name):
	queue_free()
