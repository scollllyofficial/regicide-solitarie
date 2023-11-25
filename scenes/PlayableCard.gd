extends Node2D
class_name PlayableCard

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
signal reparentPlayableCard
# CARDS ATTRIBUTES
var suitValue: String
var value: int
var suit: String

enum CARD_MOVEMENT { ATTACK, DRAGGED, RELEASED }
var movementState: CARD_MOVEMENT

var initial_position: Vector2 = Vector2.ZERO
var attackedToRoyaltyCard: bool = false
var royaltyCardToAttack: Node2D
var dragOffset: Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	movementState = CARD_MOVEMENT.RELEASED
	if suitValue != null:
		suit = suitValue.left(1)
		value = int(suitValue.substr(1))
		animation.animation = suit
		animation.frame = value -1
	initial_position = global_position
	print("READY")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match movementState:
		CARD_MOVEMENT.ATTACK:
			pass
#			var _offsetAttack =  royaltyCardToAttack.attackedCardsLayer.get_children().size() * 30
#			reparent(royaltyCardToAttack.attackedCardsLayer)
#			global_position = royaltyCardToAttack.global_position + Vector2(0, 10 + _offsetAttack)	
#			movementState = 5
		CARD_MOVEMENT.DRAGGED:
			global_position = get_global_mouse_position() - dragOffset
		CARD_MOVEMENT.RELEASED:
			if royaltyCardToAttack != null:
				movementState = CARD_MOVEMENT.ATTACK
				reparentPlayableCard.emit(self, royaltyCardToAttack)
				return
			global_position = initial_position
		_:
			print("Oh snap! It's a string!")


func _on_area_2d_input_event(viewport, event, shape_idx):
	if movementState != CARD_MOVEMENT.ATTACK:
		if event is InputEventMouseButton && event.is_pressed():
			if movementState == CARD_MOVEMENT.RELEASED:
				dragOffset = get_global_mouse_position() - global_position
				movementState = CARD_MOVEMENT.DRAGGED			
		elif event is InputEventMouseButton && event.is_released():
			movementState = CARD_MOVEMENT.RELEASED
		
func removeAndDelete():
	var parent = get_parent()
	if parent != null:
		parent.remove_child(self)
	queue_free()


func _on_area_2d_area_entered(area):
	if movementState != CARD_MOVEMENT.ATTACK:	
		var _royaltyCaryd:RoyaltyCard = area.get_parent()
		print("Entrando ", _royaltyCaryd)
		if _royaltyCaryd != null:
			royaltyCardToAttack = _royaltyCaryd

func _on_area_2d_area_exited(area):
	if movementState != CARD_MOVEMENT.ATTACK:
		var _royaltyCaryd:RoyaltyCard = area.get_parent()
		print("Saliendo ", _royaltyCaryd)
		if _royaltyCaryd != null:
			royaltyCardToAttack = null
		
func attackToRoyaltyCard():
	pass

