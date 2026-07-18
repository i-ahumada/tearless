extends Node
class_name Player

@export var life_value:int
@export var hit_value: int

func setup(life_initial_value:int):
	life_value = life_initial_value
	hit_value = 10

func change_life(value:int):
	life_value += value

func escape():
	pass
