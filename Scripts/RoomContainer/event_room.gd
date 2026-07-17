extends BaseRoom
class_name EventRoom

var event_dialog = preload("res://Scenes/Rooms/event_dialog.tscn")
var lore_node: LoreNode

func setup(node: MapNode) -> void:
	super(node)
	lore_node = node as LoreNode
	play()

func play():
	match lore_node.state:
		GameEnums.NodeState.ACTION: _show_lore()
		GameEnums.NodeState.MOVEMENT: pass

func _show_lore():
	var dialog: EventDialog = event_dialog.instantiate()
	add_child(dialog)
	dialog.dialog_closed.connect(_on_event_dialog_closed)
	dialog.setup(lore_node)

func _on_event_dialog_closed():
	lore_node.state = GameEnums.NodeState.MOVEMENT
	room_state_update.emit(lore_node)
