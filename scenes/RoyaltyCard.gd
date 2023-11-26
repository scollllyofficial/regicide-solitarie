extends Node2D
class_name RoyaltyCard

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var attackedCardsLayer: Node2D = $AttackedCards

signal kill
signal notifyBadCard

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
		active = true
		animation.play(suitValue)
	
func attackedPlayableCards(_playableCard, _royalCard):
	if _royalCard == self:
		print(_playableCard.playableValue)
		if attackedPoints >= value:
			if _playableCard.suit == suit:
				reparentPlayableCard(_playableCard, _royalCard)
				kill.emit()
			else:
				_playableCard.releasedMaxAttackedCard()
				notifyBadCard.emit()
				return
		else:
			if value - (attackedPoints + _playableCard.playableValue) > 10: 
				if true: # validate as(one) here
					if _playableCard.playableValue == 1:
						reparentPlayableCard(_playableCard, _royalCard)
					else:
						_playableCard.releasedMaxAttackedCard()
						notifyBadCard.emit()
						return
				else:
					_playableCard.releasedMaxAttackedCard()
					notifyBadCard.emit()
					return
			else:
				reparentPlayableCard(_playableCard, _royalCard)

		attackedPoints += _playableCard.playableValue

func killCard():
	print("kill")
	
	
func reparentPlayableCard(_card, _royalCard):
	var _attackedCardSize = attackedCardsLayer.get_children().size()
	var _offsetAttack = _attackedCardSize * 30
	attackedPoints += _card.playableValue
	_card.get_parent().remove_child(_card)	
	attackedCardsLayer.add_child(_card)
	_card.global_position = global_position + Vector2(0, 30 + _offsetAttack)
