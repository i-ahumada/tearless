extends RefCounted

class_name MapRoomCellFactory

const MAP_ROOM_CELL_SCENE = preload("res://Scenes/HUD/MiniMap/map_room_cell.tscn")

func creat_map_room_cell(node: MapNode)->MapRoomCell:
	var new_map_room_cell = MAP_ROOM_CELL_SCENE.instantiate()
	new_map_room_cell.current = false
	new_map_room_cell.visible = false
	match node.type:
		GameEnums.NodeType.COMBAT:
			new_map_room_cell.setup(
				node.id,
				null,
				Color.RED,
				node.node_directions
			)
		GameEnums.NodeType.LORE:
			new_map_room_cell.setup(
				node.id,
				null,
				Color.BLUE_VIOLET,
				node.node_directions
			)
		GameEnums.NodeType.ITEM:
			new_map_room_cell.setup(
				node.id,
				null,
				Color.DARK_ORANGE,
				node.node_directions
			)
		GameEnums.NodeType.EMPTY:
			new_map_room_cell.setup(
				node.id,
				null,
				Color.LIGHT_GRAY,
				node.node_directions
			)
		GameEnums.NodeType.NEXT_LEVEL:
			new_map_room_cell.setup(
				node.id,
				null,
				Color.GOLDENROD,
				node.node_directions
			)
		GameEnums.NodeType.END:
			new_map_room_cell.setup(
				node.id,
				null,
				Color.NAVY_BLUE,
				node.node_directions
			)
	return new_map_room_cell
