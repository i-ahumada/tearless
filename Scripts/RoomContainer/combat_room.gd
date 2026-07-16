extends BaseRoom
class_name CombatRoom

var enemies:Array[GameEnums.Enemies]
var start_dialoge:Array
var end_dialoge:Array

func setup(map_node:MapNode) -> void:
	super(map_node)
	var node: CombatNode = map_node as CombatNode
	enemies = node.enemies
	start_dialoge = node.start_dialogue
	end_dialoge = node.end_dialogue
