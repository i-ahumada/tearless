extends MarginContainer

func start(map_graph: MapGraph):
	$Minimap.create_mini_map(map_graph)

func reset(map_graph):
	$Minimap.clear()
	$Minimap.create_mini_map(map_graph)

func update(node_id: int):
	$Minimap.switch_room(node_id)
