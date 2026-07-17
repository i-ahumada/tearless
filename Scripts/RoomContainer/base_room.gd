extends Node2D
class_name BaseRoom
#Clase base para hacer herencia con las demas (Combat | Event)

@export var background: TextureRect
@export var route:String = "res://Sprites/Rooms/"

signal room_state_update(node: MapNode)

var objects: Array

func set_background(new_background_path):
	background.texture = load(new_background_path)

func setup (node:MapNode):
	set_background(route + node.background)

func play():
	pass
