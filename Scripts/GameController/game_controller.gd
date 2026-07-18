extends Node

@export var starting_map_route: String = "res://Maps/map_test.json"
@export var room_container: RoomContainer
var player: Player

signal change_room(map_node: MapNode, direction: GameEnums.Directions)
signal change_level(map_graph: MapGraph)
signal hit_enemy(damage: int)
signal hit_player(damage: int)
signal defend_player()

## Level nbr
var level: int = 1

## MapGraph structure that corresponds to the current map level
var map_graph: MapGraph

func _ready():
	map_graph = MapGraph.new(starting_map_route)
	$HUD.start(map_graph)
	$RoomContainer.redraw_room(map_graph.start_node)
	$Player.setup(100)
	player = $Player

func _on_direction_button_clicked(direction: GameEnums.Directions):
	if (map_graph.peek_next(direction) == GameEnums.NodeType.NEXT_LEVEL):
		change_level.emit(map_graph)
	else:
		map_graph.move_direction(direction) # sacar cuando se implemente _next_room()
		change_room.emit(map_graph.current_node, direction)

func _on_update_room_state(room_node: MapNode):
	$HUD.update_room_state(room_node)
	# actualiza según lo que envíe el container del Room
	# avisa al hud el cambio de estado

func _on_hit_player(damage: int):
	player.change_life(-damage)
	$HUD.update_player_life(player.life_value)

# Se recibe desde el hud cuando se usan los botones de navegación
# _load_room(room_data: RoomData):
	# avisa el cambio al RoomContainer. RoomContainer.change_room(room_data)
	# actualiza el mapa
	#actualizar el hud (desactivar movimiento que no se puede)

func _on_skill_button_cliked(skill: GameEnums.Skills) -> void:
	assert(map_graph.current_node.type == GameEnums.NodeType.COMBAT)

	match skill:
		GameEnums.Skills.ATTACK:
			hit_enemy.emit(-$Player.hit_value)
		GameEnums.Skills.DEFEND:
			defend_player.emit()
		GameEnums.Skills.ESCAPE:
			match map_graph.last_direction_moved:
				GameEnums.Directions.LEFT: map_graph.move_direction(GameEnums.Directions.RIGHT)
				GameEnums.Directions.RIGHT: map_graph.move_direction(GameEnums.Directions.LEFT)
				GameEnums.Directions.UP: map_graph.move_direction(GameEnums.Directions.DOWN)
				GameEnums.Directions.DOWN:  map_graph.move_direction(GameEnums.Directions.UP)
				GameEnums.Directions.NONE:
					$HUD.set_dialogue(["I- I can't escape..."])

func _on_show_dialogue(dialogue):
	$HUD.set_dialogue(dialogue)

func _change_turn(turn):
	$HUD.combat_change_turn(turn)
