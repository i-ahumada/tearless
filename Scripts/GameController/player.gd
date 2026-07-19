extends Node
class_name Player

@export var life_value:int
@export var hit_value: int
@export var escape_counter:int

signal no_escape()
signal escape_not_allowed()

func setup(life_initial_value:int):
	life_value = life_initial_value
	hit_value = 10
	escape_counter = 10

func change_life(value:int):
	life_value += value

func set_escape_counter(new_value:int):
	escape_counter = new_value

func escape():
	escape_counter -= 1


func _on_escape_player() -> void:
	escape()
	if escape_counter == 0:
		no_escape.emit()
		escape_not_allowed.emit()
