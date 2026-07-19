extends Node2D
class_name Enemy

@export var life_value: int
@export var damage_value: int = 10
@onready var enemy_sprite:Sprite2D = $Area2D/CollisionShape2D/EnemySprite2D
@onready var selected_sprite:Sprite2D = $Area2D/CollisionShape2D/SelectedSprite2D
@onready var enemy_area = $Area2D

signal enemy_selected(enemy_id)

# No creo que esto sea un diccionario,
# Creo que es su propia cosa, que para sacar atacas implementa una cola
# Pero guarda el patrón para poder mostrarlo por pantalla
var attack_pattern: AttackPattern
var dialogue: Array
var id

func setup(life_initial_value: int, icon_route:String, new_id, damage):
	selected_sprite.visible = false
	life_value = life_initial_value
	id = new_id
	damage_value = damage
	enemy_sprite.texture = load(icon_route) as Texture2D
	initial_position(640,360)
	_scale(4)

func set_attack_pattern(pattern: AttackPatternsDict.AttackPatternsReference):
	attack_pattern = AttackPattern.new(pattern)

func update_life(value:int):
	life_value += value

func initial_position(x_value:float,y_value:float):
	enemy_area.position.x = x_value
	enemy_area.position.y = y_value

func _scale(scale_value):
	enemy_area.scale.x = scale_value
	enemy_area.scale.y = scale_value

func get_action():
	return attack_pattern.next_attack()

func get_pattern():
	return attack_pattern.pattern

func unselect():
	selected_sprite.visible = false

func select():
	selected_sprite.visible = true

func _on_enemy_clicked():
	enemy_selected.emit(id)
	selected_sprite.visible = true
