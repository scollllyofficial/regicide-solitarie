class_name Card

var value: int
var suit: String

func _init(_value, _suit) -> void:
	self.value = _value
	self.suit = _suit
	print("value", value)
