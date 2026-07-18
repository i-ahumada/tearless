extends Node
class_name RoomContainer

@export var state: GameEnums.NodeState

signal hit_player(damage: int)
signal change_turn(turn: GameEnums.CombatTurn)
signal show_dialogue(dialogue)
signal update_room_state(room_node: MapNode)

var room_factory: RoomFactory

func _ready() -> void:
	room_factory = RoomFactory.new()

func redraw_room(map_node):
	for child in get_children():
		child.queue_free()
	var room = room_factory.instanciate_room(map_node)
	add_child(room)
	room = room_factory.setup_room(self, room, map_node) # 🙏

func _on_change_room(map_node, direction: GameEnums.Directions):
	redraw_room(map_node)

## This method is connected dynamically with the room it contains
func _on_room_state_update(room_node: MapNode):
	update_room_state.emit(room_node)

func _on_show_dialogue(dialogue):
	show_dialogue.emit(dialogue)

func _on_change_turn(turn: GameEnums.CombatTurn):
	change_turn.emit(turn)

func _on_hit_player(damage: int):
	hit_player.emit(damage)

func _on_hit_enemy(damage:int):
	var room = get_child(0)
	room = room as CombatRoom
	room.player_attack(damage)

func _on_player_defend():
	var room = get_child(0)
	room = room as CombatRoom
	room.player_defend()
