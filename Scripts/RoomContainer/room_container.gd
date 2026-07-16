extends Node2D
class_name RoomContainer

@export var state: GameEnums.NodeState
var room_factory: RoomFactory

func _ready() -> void:
	room_factory = RoomFactory.new()

func change_room(map_node:MapNode):
	for child in get_children():
		child.queue_free()
	add_child(room_factory.create_room(map_node))
