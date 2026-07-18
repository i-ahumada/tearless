extends RefCounted

class_name MapGraph

# IVAN:
# La verdad que es mil veces más cómodo representarlo con una matriz, qsy

const START_NODE = "START"
var map_node_factory: MapNodeFactory = MapNodeFactory.new()
var start_node: MapNode = null
var last_direction_moved: GameEnums.Directions = GameEnums.Directions.NONE
var current_node: MapNode = null
var node_set: Dictionary = {}

func _init(map_path: String):
	var map_data: Dictionary = _load_map(map_path)
	_create_graph(map_data)

func move_direction(direction: GameEnums.Directions)-> void:
	assert(current_node.node_directions[direction] != null, "ERROR: Impossible movement")
	last_direction_moved = direction
	current_node = current_node.node_directions[direction]
	current_node.visited = true

func peek_next(direction: GameEnums.Directions)-> GameEnums.NodeType:
	assert(current_node.node_directions[direction] != null, "ERROR: Impossible movement")

	return current_node.node_directions[direction].type

func _load_map(map_path: String)-> Dictionary:
	if !FileAccess.file_exists(map_path):
		return {}
	var f = FileAccess.open(map_path, FileAccess.READ)
	var map_json = JSON.new()
	var error = map_json.parse(f.get_as_text())

	# it should never be unable to load a map
	assert(error == OK)

	var map_data = map_json.data
	if typeof(map_data) == TYPE_DICTIONARY:
		return map_data
	else:
		return {}

## Recursively creates map_graph from json file
func _create_graph(map_data: Dictionary)-> void:
	var start_node_data: Dictionary = map_data.get(START_NODE)
	start_node = _create_node(start_node_data, map_data)
	current_node = start_node
	start_node.visited = true

func _create_node(node_data: Dictionary, map_data: Dictionary)-> MapNode:
	var node: MapNode = map_node_factory.create_node(node_data)
	node_set.set(node.id, node) # { 0: 0x1231494, 1: 0x12394895, ... }

	## Esta parte tiene que morir YA, funciona para ahora pero es un ASCO
	_attach_node_if_valid(GameEnums.Directions.LEFT, node_data["directions"]["LEFT"], map_data, node)
	_attach_node_if_valid(GameEnums.Directions.RIGHT, node_data["directions"]["RIGHT"], map_data, node)
	_attach_node_if_valid(GameEnums.Directions.UP, node_data["directions"]["UP"], map_data, node)
	_attach_node_if_valid(GameEnums.Directions.DOWN, node_data["directions"]["DOWN"], map_data, node)

	return node

func _attach_node_if_valid(direction: GameEnums.Directions, node_key, map_data: Dictionary, node: MapNode):
	if (node_key):
		if (node_set.has(int(map_data[node_key]["id"]))):
			node.node_directions[direction] = node_set.get(int(map_data[node_key]["id"]))
		else:
			var new_node = _create_node(map_data[node_key], map_data)
			node.node_directions[direction] = new_node
