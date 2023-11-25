extends Node2D
class_name RoyaltyCard

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var attackedCardsLayer: Node2D = $AttackedCards

var suitValue: String
var value: int
var suit: String

func _ready():
	if suitValue != null:
		suit = suitValue.left(1)
		value = int(suitValue.substr(1))
		animation.play(suitValue)

	
func activate():
	var cardId: String =  suit + str(value) 
	animation.play(cardId)
	
