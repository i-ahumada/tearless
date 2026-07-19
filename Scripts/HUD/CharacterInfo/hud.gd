extends CanvasLayer

signal direction_button_clicked(direction: GameEnums.Directions)
signal skill_button_cliked(skill: GameEnums.Skills)

var escape_allowed:bool = true

func start(map_graph: MapGraph):
	$CharacterInfo.set_dialogue(["..."])
	_enable_valid_inputs(map_graph.current_node)
	$MiniMap.start(map_graph)

func set_dialogue(dialogue):
	$CharacterInfo.set_dialogue(dialogue)

func combat_change_turn(turn: GameEnums.CombatTurn):
	if (turn == GameEnums.CombatTurn.PLAYER):
		$CharacterInfo.enable_skills(escape_allowed)
	elif (turn == GameEnums.CombatTurn.ENEMY):
		$CharacterInfo.disable_skills()

func _on_character_info_direction_button_clicked(direction):
	direction_button_clicked.emit(direction)

func _on_change_level(map_graph: MapGraph):
	$CharacterInfo.set_dialogue("...")
	$MiniMap.reset(map_graph)

func _enable_valid_inputs(room_node: MapNode):
	$CharacterInfo.disable_skills()
	if (room_node.state == GameEnums.NodeState.MOVEMENT):
		$CharacterInfo.enable_only_valid_directions(room_node)
	else:
		$CharacterInfo.disable_all_directions()

func update_player_life(life):
	$CharacterInfo.update_life(life)

func _on_change_room(map_node: MapNode, direction: GameEnums.Directions):
	$MiniMap.update(map_node.id, direction)
	_enable_valid_inputs(map_node)

func update_room_state(room_node: MapNode):
	_enable_valid_inputs(room_node)

func disable_escape():
	$CharacterInfo.disable_escape_button()

func _on_character_info_skill_button_clicked(skill: GameEnums.Skills) -> void:
	skill_button_cliked.emit(skill)


func _on_escape_not_allowed() -> void:
	escape_allowed = false
