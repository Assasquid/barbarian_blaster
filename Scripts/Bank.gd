extends MarginContainer

@export var starting_money := 150

@onready var label: Label = $Label
@onready var time_left_label: Label = $TimeLeftLabel


var money: int:
	set(new_value):
		#money = new_value
		#if money < 0:
			#money = 0
		# The three lines above can be replaced with:
		money = max(new_value, 0)
		label.text = "Money: " + str(money) + "$"


var time_left: String:
	set(new_value):
		time_left = new_value
		time_left_label.text = new_value


func _ready() -> void:
	money = starting_money
