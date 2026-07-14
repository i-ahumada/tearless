extends RefCounted

class_name MapNodeFactory

func create_node(node_data: Dictionary)-> MapNode:
	match NodeUtils.node_data_type_to_enum(node_data["type"]):
		GameEnums.NodeType.COMBAT: return CombatNode.new(node_data)
		GameEnums.NodeType.LORE: return LoreNode.new(node_data)
		_: return MapNode.new(node_data)
