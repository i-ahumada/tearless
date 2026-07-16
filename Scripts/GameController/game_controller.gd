extends Node

@export var starting_map_route: String = "res://Maps/map_test.json"
@export var room_container: RoomContainer

signal change_room(map_node: MapNode)
signal change_level(map_graph: MapGraph)
signal enemy_hit(damage: int)
signal player_hit(damage: int)

## Level nbr
var level: int = 1

## MapGraph structure that corresponds to the current map level
var map_graph: MapGraph

func _ready():
	map_graph = MapGraph.new(starting_map_route)
	$HUD.start(map_graph)

func _on_direction_button_clicked(direction: GameEnums.Directions):
	if (map_graph.peek_next(direction) == GameEnums.NodeType.NEXT_LEVEL):
		change_level.emit(map_graph)
	else:
		map_graph.move_direction(direction) # sacar cuando se implemente _next_room()
		change_room.emit(map_graph.current_node)

func _on_update_room_state():
	pass
	# actualiza según lo que envíe el container del Room
	# avisa al hud el cambio de estado

# Se recibe desde el hud cuando se usan los botones de navegación
# _load_room(room_data: RoomData):
	# avisa el cambio al RoomContainer. RoomContainer.change_room(room_data)
	# actualiza el mapa
	#actualizar el hud (desactivar movimiento que no se puede)
