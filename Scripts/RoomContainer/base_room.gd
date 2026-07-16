extends Node2D
class_name BaseRoom
#Clase base para hacer herencia con las demas (Combat | Event)

@export var background: TextureRect
@export var route:String = "res://Sprites/Rooms"
var objects: Array

func set_background(new_background_path):
	background.texture = load(route + new_background_path)

func setup (node:MapNode):
	set_background(node.background)
