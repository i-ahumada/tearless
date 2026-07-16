extends MapNode

class_name CombatNode

var enemies: Array[GameEnums.Enemies]
var start_dialogue: Array
var end_dialogue: Array

func _init(node_data: Dictionary):
	super(node_data)
	for enemy: String in node_data["enemies"]:
		enemies.push_back(NodeUtils.enemy_to_enemy_enum(enemy))
	start_dialogue = node_data["start_dialogue"]
	end_dialogue = node_data["end_dialogue"]
