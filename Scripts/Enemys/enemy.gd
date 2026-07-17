extends Node2D
class_name Enemy

var attack_pattern: Dictionary
var dialogue: Array
@export var life_value: int
@export var enemy_icon: TextureRect

#const initial_position_x
#const initial_position_y

func _init(life_initial_value: int):
	life_value = life_initial_value

func set_attack_pattern(pattern):
	attack_pattern = pattern

func update_life(value:int):
	life_value += value
