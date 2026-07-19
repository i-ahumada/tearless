extends Node

class_name GameController

@export var starting_map_route: String = "res://Maps/floor_1.json"
@export var room_container: RoomContainer
@export var background_music: AudioStreamPlayer

var player: Player

signal change_game_state(new_state: Game.GameState)
signal change_room(map_node: MapNode, direction: GameEnums.Directions)
signal change_level(map_graph: MapGraph)
signal hit_enemy(damage: int)
# signal hit_player(damage: int)
signal defend_player()
signal escape_player()

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
		level += 1
		map_graph = MapGraph.new("res://Maps/floor_"+str(level)+".json")
		change_level.emit(map_graph)
	elif (map_graph.peek_next(direction) == GameEnums.NodeType.END):
		change_game_state.emit(Game.GameState.END)
	else:
		map_graph.move_direction(direction) # sacar cuando se implemente _next_room()
		change_room.emit(map_graph.current_node, direction)

func _on_update_room_state(room_node: MapNode):
	$HUD.update_room_state(room_node)
	# actualiza según lo que envíe el container del Room
	# avisa al hud el cambio de estado

func _on_hit_player(damage: int):
	player.change_life(-damage)
	if player.life_value <= 0:
		change_game_state.emit(Game.GameState.LOSE)
	$HUD.update_player_life(player.life_value)

func _on_lose():
	print("Argentina 2 - 1 Inglaterra")

# Se recibe desde el hud cuando se usan los botones de navegación
func _on_skill_button_cliked(skill: GameEnums.Skills) -> void:
	assert(map_graph.current_node.type == GameEnums.NodeType.COMBAT)

	match skill:
		GameEnums.Skills.ATTACK:
			hit_enemy.emit(-$Player.hit_value)
		GameEnums.Skills.DEFEND:
			defend_player.emit()
		GameEnums.Skills.ESCAPE:
			escape_player.emit()
			match map_graph.last_direction_moved:
				GameEnums.Directions.LEFT: _on_direction_button_clicked(GameEnums.Directions.RIGHT)
				GameEnums.Directions.RIGHT: _on_direction_button_clicked(GameEnums.Directions.LEFT)
				GameEnums.Directions.UP: _on_direction_button_clicked(GameEnums.Directions.DOWN)
				GameEnums.Directions.DOWN:  _on_direction_button_clicked(GameEnums.Directions.UP)
				GameEnums.Directions.NONE:
					$HUD.set_dialogue(["I- I can't escape..."])


func _on_show_dialogue(dialogue):
	$HUD.set_dialogue(dialogue)

func _change_turn(turn):
	$HUD.combat_change_turn(turn)


func _on_player_no_escape() -> void:
	$HUD.set_dialogue(["* You don't have more escape chances *"])
	$HUD.disable_escape()
