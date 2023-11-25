extends Node2D

@onready var deckButton: Deck = $Deck
@onready var playableCardsLayer: Node2D = $PlayableCards
@onready var royaltyCardsLayer: Node2D = $RoyaltyCards

var playableCardList: Array = [
	"C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C10", 
	"D1", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D10", 
	"S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "S10", 
	"H1", "H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "H10", 
	"T10",
	"F10"
]

var playableCardListTest: Array = [
	"C1", "C2", "C3", "C4"
]



var royaltyCardList: Array = [
	"C11", "C12", "C13",
	"D11", "D12", "D13",
	"S11", "S12", "S13",
	"H11", "H12", "H13"
]

func _ready():
	#Connect signals
	deckButton.deal.connect(dealPlayableCards)

	
	#Spawn playableCards 
	randomize() 
	playableCardListTest.shuffle()
	spawnPlayableCards()


func dealPlayableCards():
	var _oldPlayableCards: Array = playableCardsLayer.get_children()
	if _oldPlayableCards.size() > 0:
		for card in _oldPlayableCards:
			card.removeAndDelete()
	print("dealPlayableCards")
	await get_tree().create_timer(2).timeout
	spawnPlayableCards()

func spawnPlayableCards():
	const PLAYABLE_POSITIONS: Array = [Vector2(36,670), Vector2(162,670), Vector2(288,670)]
	for i in 3:
		var _cardValue = playableCardListTest.pop_back()
		if _cardValue != null:
			var _newCard:PlayableCard = preload("res://scenes/PlayableCard.tscn").instantiate()
			_newCard.suitValue = _cardValue
			_newCard.global_position = PLAYABLE_POSITIONS[i]
			_newCard.reparentPlayableCard.connect(reparentPlayableCard)
			playableCardsLayer.add_child(_newCard, true)
		else :
			break
			
func spawnRoyaltyCards():
	const PLAYABLE_POSITIONS: Array = [Vector2(36,670), Vector2(162,670), Vector2(288,670)]
	for i in 3:
		var _cardValue = playableCardListTest.pop_back()
		if _cardValue != null:
			var _newCard:PlayableCard = preload("res://scenes/PlayableCard.tscn").instantiate()
			_newCard.suitValue = _cardValue
			_newCard.global_position = PLAYABLE_POSITIONS[i]
			playableCardsLayer.add_child(_newCard)
		else :
			break
			
func reparentPlayableCard(_card: PlayableCard, _royalty: Node2D):
	var _offsetAttack = _royalty.attackedCardsLayer.get_children().size() * 30
	playableCardsLayer.remove_child(_card)	
	_royalty.attackedCardsLayer.add_child(_card)
	_card.global_position = _royalty.global_position + Vector2(0, 30 + _offsetAttack)
	
