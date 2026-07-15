extends CanvasLayer

signal direction_button_clicked(direction: GameEnums.Directions)

func _on_character_info_direction_button_clicked(direction):
	direction_button_clicked.emit(direction)

func start_mini_map(map_graph: MapGraph):
	$MiniMap.start(map_graph)

func reset_mini_map(map_graph: MapGraph):
	$MiniMap.reset(map_graph)

func move_room_mini_map(node_id: int):
	$MiniMap.update(node_id)
