extends Node
class_name RoomContainer

@export var state: GameEnums.NodeState

signal update_room_state(room_node: MapNode)

var room_factory: RoomFactory

func _ready() -> void:
	room_factory = RoomFactory.new()

func redraw_room(map_node):
	for child in get_children():
		child.queue_free()
	var room = room_factory.create_room(map_node)
	add_child(room)
	room.room_state_update.connect(_on_room_state_update)

func _on_change_room(map_node, direction: GameEnums.Directions):
	redraw_room(map_node)

## This method is connected dynamically with the room it contains
func _on_room_state_update(room_node: MapNode):
	update_room_state.emit(room_node)
