extends RefCounted

class_name MapNode

@export var type: GameEnums.NodeType = GameEnums.NodeType.EMPTY
var id: int = -1
var visited: bool = false
var state: GameEnums.NodeState
var node_directions: Dictionary[GameEnums.Directions,MapNode] = {
	GameEnums.Directions.LEFT: null,
	GameEnums.Directions.RIGHT: null,
	GameEnums.Directions.UP: null,
	GameEnums.Directions.DOWN: null,
}

func _init(node_data: Dictionary):
	id = int(node_data["id"])
	type = NodeUtils.node_data_type_to_enum(node_data["type"])
	visited = node_data["visited"]
	state = NodeUtils.node_data_state_to_enum(node_data["state"])
