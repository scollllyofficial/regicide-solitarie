extends Node2D
class_name RoyaltyCard

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var attackedCardsLayer: Node2D = $AttackedCards

signal kill

var suitValue: String
var value: int
var suit: String
var active: bool = false
var readyToKill: bool = false

var attackedPoints: int = 0

func _ready():
	
	#Signals
	kill.connect(killCard)
	
	if suitValue != null:
		suit = suitValue.left(1)
		value = int(suitValue.substr(1))
		if active:
			activate()
			
	
func activate():
	if suitValue != null:
		animation.play(suitValue)
	
func attackedPlayableCards(_card: PlayableCard, _royalCard: RoyaltyCard):
	if _royalCard == self:
		var _attackedCardSize = attackedCardsLayer.get_children().size()
		var _offsetAttack = _attackedCardSize * 30
		attackedPoints += _card.value
		# Attacked points are ready to kill
		if _attackedCardSize >= 2: #attackedPoints >= value:
			if _card.suit != _royalCard.suit:
				_card.releasedMaxAttackedCard()
			else:
				readyToKill = true
		_card.get_parent().remove_child(_card)	
		attackedCardsLayer.add_child(_card)
		_card.global_position = global_position + Vector2(0, 30 + _offsetAttack)
		if readyToKill:
			kill.emit()

func killCard():
	print("kill")
