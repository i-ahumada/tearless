extends CanvasLayer

signal direction_button_clicked(direction: GameEnums.Directions)

func start(map_graph: MapGraph):
	$CharacterInfo.set_dialogue("...")
	$CharacterInfo.enable_only_valid_directions(map_graph.start_node)
	$MiniMap.start(map_graph)


func set_dialogue(dialogue):
	$CharacterInfo.set_dialogue(dialogue)

func _on_character_info_direction_button_clicked(direction):
	direction_button_clicked.emit(direction)

func _on_change_level(map_graph: MapGraph):
	$CharacterInfo.set_dialogue("...")
	$MiniMap.reset(map_graph)

func _on_change_room(map_node: MapNode, direction: GameEnums.Directions):
	$MiniMap.update(map_node.id, direction)

	if (map_node.state == GameEnums.NodeState.MOVEMENT):
		$CharacterInfo.enable_only_valid_directions(map_node)
	else:
		$CharacterInfo.disable_all_directions()
