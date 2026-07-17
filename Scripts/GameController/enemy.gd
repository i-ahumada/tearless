extends Node
class_name Enemy

var attack_pattern: Dictionary
var dialogue: Array
@export var life_value: int
#var imagen de enemigo

func _init(life_initial_value: int):
	life_value = life_initial_value
