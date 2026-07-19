extends Control

# This constants are used to create the minimap cells
# They add themselves to a previous position to position the cells relative to others
const ADD_LEFT: Vector2i = Vector2i(-25,0)
const ADD_RIGHT: Vector2i = Vector2i(25,0)
const ADD_UP: Vector2i = Vector2i(0,-25)
const ADD_DOWN: Vector2i = Vector2i(0,25)

var current_room_cell: MapRoomCell = null
var _map_room_cell_factory = MapRoomCellFactory.new()
var _map_room_cell_set: Dictionary[int, MapRoomCell]

func switch_room(node_id: int, direction: GameEnums.Directions):
	current_room_cell.leave()
	_map_room_cell_set.get(node_id).visit()
	current_room_cell = _map_room_cell_set.get(node_id)
	_hint_neighbours(current_room_cell)
	var movement: Vector2 = Vector2i(0,0)

	match direction:
		GameEnums.Directions.LEFT: movement = ADD_RIGHT
		GameEnums.Directions.RIGHT: movement = ADD_LEFT
		GameEnums.Directions.UP: movement = ADD_DOWN
		GameEnums.Directions.DOWN: movement = ADD_UP

	for map_room_cell_id in _map_room_cell_set:
		_map_room_cell_set[map_room_cell_id].position += movement

func clear():
	for child in get_children():
		child.queue_free()
	_map_room_cell_set.clear()
	current_room_cell = null

func _hint_neighbours(room_cell: MapRoomCell):
	for neighbour_id in room_cell.neighbours:
		if _map_room_cell_set.has(neighbour_id):
			var neighbour: MapRoomCell = _map_room_cell_set.get(neighbour_id)
			if (!neighbour.visible):
				neighbour.hint()

func create_mini_map(map_graph: MapGraph):
	_add_map_room_cell(map_graph.current_node, position + size / 2)
	current_room_cell = _map_room_cell_set.get(map_graph.current_node.id)
	current_room_cell.visit()
	_hint_neighbours(current_room_cell)

func _add_map_room_cell(node: MapNode, node_position: Vector2i):
	var map_room_cell: MapRoomCell = _map_room_cell_factory.creat_map_room_cell(node)
	_map_room_cell_set.set(node.id, map_room_cell)
	add_child(map_room_cell)
	map_room_cell.position = node_position

	_add_node_if_not_added(node.node_directions[GameEnums.Directions.LEFT], node_position + ADD_LEFT)
	_add_node_if_not_added(node.node_directions[GameEnums.Directions.RIGHT], node_position + ADD_RIGHT)
	_add_node_if_not_added(node.node_directions[GameEnums.Directions.UP], node_position + ADD_UP)
	_add_node_if_not_added(node.node_directions[GameEnums.Directions.DOWN], node_position + ADD_DOWN)

func _add_node_if_not_added(node: MapNode, node_position: Vector2i):
	if (node and !_map_room_cell_set.has(node.id)):
		_add_map_room_cell(node, node_position)
