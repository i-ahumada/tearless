extends RefCounted

class_name NodeUtils

static func node_data_type_to_enum(node_type: String)->GameEnums.NodeType:
	match node_type:
		"COMBAT": return GameEnums.NodeType.COMBAT
		"LORE": return GameEnums.NodeType.LORE
		"ITEM": return GameEnums.NodeType.ITEM
		"EMPTY": return GameEnums.NodeType.EMPTY
		"NEXT_LEVEL": return GameEnums.NodeType.NEXT_LEVEL
		"END": return GameEnums.NodeType.END
	return GameEnums.NodeType.EMPTY

static func node_data_state_to_enum(node_state: String)->GameEnums.NodeState:
	match node_state:
		"ACTION": return GameEnums.NodeState.ACTION
		"MOVEMENT": return GameEnums.NodeState.MOVEMENT
	return GameEnums.NodeState.MOVEMENT

static func enemy_to_enemy_enum(enemy: String)-> GameEnums.Enemies:
	match enemy:
		"SPIDER": return GameEnums.Enemies.SPIDER # Julián Álvarez
		"ZOMBIE": return GameEnums.Enemies.ZOMBIE
	return GameEnums.Enemies.SPIDER
