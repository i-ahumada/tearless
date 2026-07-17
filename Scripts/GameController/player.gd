extends Node
class_name Player

@export var life_value:int

func _init(life_initial_value:int):
	life_value = life_initial_value

func update_life(value:int):
	life_value += value

func escape():
	pass
