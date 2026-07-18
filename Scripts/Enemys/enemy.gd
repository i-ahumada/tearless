extends Node2D
class_name Enemy

var attack_pattern: Dictionary
var dialogue: Array
var id
@export var life_value: int
@onready var enemy_sprite:Sprite2D = $Sprite2D

func setup(life_initial_value: int, icon_route:String, new_id):
	life_value = life_initial_value
	id = new_id
	enemy_sprite.texture = load(icon_route) as Texture2D
	initial_position(640,360)
	_scale(10)

func set_attack_pattern(pattern):
	attack_pattern = pattern

func update_life(value:int):
	life_value += value
	print("enemy's life: ", life_value)

func initial_position(x_value:float,y_value:float):
	enemy_sprite.position.x = x_value
	enemy_sprite.position.y = y_value

func _scale(scale_value):
	enemy_sprite.scale.x = scale_value
	enemy_sprite.scale.y = scale_value
