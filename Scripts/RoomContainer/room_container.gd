extends Node
class_name RoomContainer

@export var state: GameEnums.NodeState
var room_factory: RoomFactory

func _ready() -> void:
	room_factory = RoomFactory.new()

func redraw_room(map_node):
	for child in get_children():
		child.queue_free()
	add_child(room_factory.create_room(map_node))

func _on_change_room(map_node, direction: GameEnums.Directions):
	redraw_room(map_node)
	#print("bg: ",map_node.background)
