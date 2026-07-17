extends BaseRoom
class_name CombatRoom

var combat_node: CombatNode
# var enemies:Array[GameEnums.Enemies]
# var start_dialoge:Array
# var end_dialoge:Array

func setup(map_node:MapNode) -> void:
	super(map_node)
	combat_node = map_node as CombatNode
	_combat_flow()

func _combat_flow():
	_show_dialogue(combat_node.start_dialogue)
	_combat()
	_show_dialogue(combat_node.end_dialogue)

func _show_dialogue(dialogue: Array):
	pass

func _combat():
	pass
