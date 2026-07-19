extends BaseRoom
class_name CombatRoom

# Esto para la parte de combate está diseñado bastante mal (my b)
# Para el combate no creo que habría que tener que hacer un pasamanos tan grande
# Para mi esta cosa tendría que tener una referencia al jugador
# Despues se les podría hacer implementar una interfaz para tenerlos tipados en el arreglo
# O que hereden de CombatEntity o algo así, por ahora le pongo una constante
# Malisimo pero este bloque de texto no se borra hasta que lo cambiemos
# Por las dudas no te quiero cambiar nada

signal change_turn(turn: GameEnums.CombatTurn)
signal hit_player(damage: int)

var combat_node: CombatNode
var enemy_factory: EnemyFactory = EnemyFactory.new()
var enemies:Dictionary[int,Enemy]
var selected_enemy: Enemy = null
var turn_queue: Array
var player_defending = false

const TURN_DURATION = 1.5
const PLAYER_ID = -1
const enemy_scene = preload("res://Scenes/Enemies/enemy.tscn")

func setup(map_node:MapNode) -> void:
	super(map_node)

	combat_node = map_node as CombatNode

	#enemies.get(1).initial_position(340,360) hay que variar las posiciones de los enemigos
	_combat_flow()

func _combat_flow():
	match combat_node.state:
		GameEnums.NodeState.COMBAT:
			var enemy_counter:int = 0
			var enemy:Enemy

			for enemy_name in combat_node.enemies:
				enemy = enemy_scene.instantiate() as Enemy
				add_child(enemy)

				enemy = enemy_factory.create_enemy(enemy_name,enemy,enemy_counter)
				enemy.enemy_selected.connect(_select_enemy)

				$PanelContainer/PatternDisplay.add_pattern(enemy.get_pattern())
				enemies.set(enemy.id,enemy)
				enemy_counter += 1

			selected_enemy = enemies[0]
			selected_enemy.select()
			# _show_dialogue(combat_node.start_dialogue)
			_start_combat()
		GameEnums.NodeState.ACTION: pass
		GameEnums.NodeState.MOVEMENT: pass

func _select_enemy(enemy_id):
	if selected_enemy:
		selected_enemy.unselect()
	selected_enemy = enemies[enemy_id]

func _show_dialogue(dialogue: Array):
	display_dialogue.emit(dialogue)

func _start_combat():
	# start turn_queue
	turn_queue.push_back(PLAYER_ID)
	for enemy_id in enemies:
		turn_queue.push_back(enemy_id)
	$PanelContainer/PatternDisplay.visible = true
	$PanelContainer/PatternDisplay.display()
	_run_combat_step()

func _run_combat_step():
	var current_turn_id = turn_queue.pop_front()

	if (current_turn_id != PLAYER_ID):
		assert(enemies[current_turn_id])

		var enemy = enemies[current_turn_id]
		var enemy_action = enemy.get_action() # pop_from_attack_queue

		if (enemy_action == GameEnums.EnemiesActions.ATTACK):
			if (player_defending):
				_show_dialogue([" dodges "])
			else:
				hit_player.emit(enemy.damage_value)

		turn_queue.push_back(current_turn_id)

		await get_tree().create_timer(TURN_DURATION).timeout
		_eval_end_turn()
	else:
		turn_queue.push_back(PLAYER_ID)
		change_turn.emit(GameEnums.CombatTurn.PLAYER)

func _eval_end_turn():
	# Ni se usa esto
	if (!turn_queue.has(PLAYER_ID)):
		_lose()
	elif (turn_queue.has(PLAYER_ID) and turn_queue.size() == 1):
		_win()
	else:
		_run_combat_step()

func _lose():
	print("Argentina 2 - 1 England")

func _win():
	combat_node.state = GameEnums.NodeState.MOVEMENT
	room_state_update.emit(combat_node)

func player_defend():
	player_defending = true
	await get_tree().create_timer(TURN_DURATION).timeout
	_eval_end_turn()

func player_attack(damage:int):
	player_defending = false
	if (selected_enemy):
		selected_enemy.update_life(damage)
		if (selected_enemy.life_value <= 0):
			var i = 0
			while (i < turn_queue.size() and turn_queue[i] != selected_enemy.id):
				i += 1
			if (turn_queue[i] == selected_enemy.id):
				turn_queue.pop_at(i)
			selected_enemy.queue_free()

		await get_tree().create_timer(TURN_DURATION).timeout
		change_turn.emit(GameEnums.CombatTurn.ENEMY)
		_eval_end_turn()

	else:
		_show_dialogue(["Who should I attack?"])
