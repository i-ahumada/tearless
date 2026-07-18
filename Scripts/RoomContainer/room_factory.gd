extends Node
class_name RoomFactory

const base_room = preload("res://Scenes/Rooms/base_room.tscn")
const combat_room = preload("res://Scenes/Rooms/combat_room.tscn")
const event_room = preload("res://Scenes/Rooms/event_room.tscn")


func instanciate_room(map_node: MapNode) -> BaseRoom:
	var room:BaseRoom = null

	match map_node.type:
		GameEnums.NodeType.EMPTY:
			room = base_room.instantiate()
		GameEnums.NodeType.COMBAT:
			room = combat_room.instantiate()
		GameEnums.NodeType.LORE:
			room = event_room.instantiate()
		GameEnums.NodeType.ITEM:
			pass
		GameEnums.NodeType.NEXT_LEVEL:
			pass
		GameEnums.NodeType.END:
			pass

	return room

func setup_room(room:BaseRoom, map_node: MapNode) -> BaseRoom:
	match map_node.type:
		GameEnums.NodeType.EMPTY:
			room = room as BaseRoom
			room.setup(map_node)
		GameEnums.NodeType.COMBAT:
			room = room as CombatRoom
			room.setup(map_node)
		GameEnums.NodeType.LORE:
			room = room as EventRoom
			room.setup(map_node)
		GameEnums.NodeType.ITEM:
			pass
		GameEnums.NodeType.NEXT_LEVEL:
			pass
		GameEnums.NodeType.END:
			pass
	return room
