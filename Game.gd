extends Node2D


# Called when the node enters the scene tree for the first time.
var battlePage = preload("res://pages/BattlePage.tscn")
@onready var currentPage = $CurrentPage

func _ready():
	var _currentPageScene = battlePage.instantiate()
	currentPage.add_child(_currentPageScene)
