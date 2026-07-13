extends Node2D

# +---------------------------------------------------------+
# | Maneja que se carga, la navegación y mantiene el estado |
# +---------------------------------------------------------+

# variable que sea MapGraph -> Corresponde al nivel actual.

# _on_direction_button_clicked(direction: DirectionEnum):
	# if (current_node.peek_next(direction) == NodeType.NEXT_LEVEL):
		# _next_level(direction)
	# else
		# _next_room(direction)

# _next_room -> avanzar en el mapa
	# next_node: MapNode = current_node.next(direction)
	# _load_room(current_node)

# _next_level -> avanzar en el nivel
	# Reemplazar el grafo por otro map = new MapGraph(path/to/map)
	# _load_room(map.start_node)
	# avisar al hud

# _on_update_room_state():
	# actualiza según lo que envíe el container del Room
	# avisa al hud el cambio de estado

# Se recibe desde el hud cuando se usan los botones de navegación
# _load_room(room_data: RoomData):
	# avisa el cambio al RoomContainer. RoomContainer.change_room(room_data)
	# actualiza el mapa
	# envia de vuelta al hud para el minimapa?
