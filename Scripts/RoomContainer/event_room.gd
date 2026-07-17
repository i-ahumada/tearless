extends BaseRoom
class_name EventRoom

var lore_node: LoreNode

func setup(node: MapNode) -> void:
	super(node)
	lore_node = node as LoreNode
	_show_lore()

func _show_lore():
	pass
	# instanciar event_dialog
