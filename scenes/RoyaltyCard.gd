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
var parentNode: Node2D

var attackedPoints: int = 0

func _ready():
	
	#Signals
	#kill.connect(killCard)
	parentNode = get_parent()
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
				killCard()
			else:
				_playableCard.releasedMaxAttackedCard()
				notifyBadCard.emit("It takes the same suit to kill royalty")
				return
		else:
			if attackedPoints > 0:
				if attackedPoints + _playableCard.playableValue >= value: 
					reparentPlayableCard(_playableCard, _royalCard)
				else:
					_playableCard.releasedMaxAttackedCard()
					notifyBadCard.emit("This card is not high enough :(")
					return
			else:
				if value-(attackedPoints + _playableCard.playableValue) > 10: 
					if _playableCard.playableValue == 1:# and Global.stackableAces:
						reparentPlayableCard(_playableCard, _royalCard)
					else:
						_playableCard.releasedMaxAttackedCard()
						notifyBadCard.emit("This card is not high enough :(")
						return
					
				else:
					reparentPlayableCard(_playableCard, _royalCard)

func killCard():
	print("kill")
	queue_free()
	#kill.emit(get_parent())
	
	
func reparentPlayableCard(_card, _royalCard):
	var _attackedCardSize = attackedCardsLayer.get_children().size()
	var _offsetAttack = _attackedCardSize * 30
	attackedPoints += _card.playableValue
	_card.get_parent().remove_child(_card)	
	attackedCardsLayer.add_child(_card)
	_card.global_position = global_position + Vector2(0, 40 + _offsetAttack)


func _on_tree_exited():
	kill.emit(parentNode)
