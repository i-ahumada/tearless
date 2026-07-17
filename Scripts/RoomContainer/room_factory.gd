extends Node
class_name RoomFactory

const base_room = preload("res://Scenes/Rooms/base_room.tscn")
const combat_room = preload("res://Scenes/Rooms/combat_room.tscn")
const event_room = preload("res://Scenes/Rooms/event_room.tscn")


func create_room(map_node: MapNode) -> BaseRoom:
	var room:BaseRoom = null

	match map_node.type:
		GameEnums.NodeType.EMPTY:
			room = base_room.instantiate()
			room.setup(map_node)
		GameEnums.NodeType.COMBAT:
			room = combat_room.instantiate()
			room.setup(map_node)
		GameEnums.NodeType.LORE:
			room = event_room.instantiate()
			room.setup(map_node)
		GameEnums.NodeType.ITEM:
			pass
		GameEnums.NodeType.NEXT_LEVEL:
			pass
		GameEnums.NodeType.END:
			pass

	return room
