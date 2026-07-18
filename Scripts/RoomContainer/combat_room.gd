extends BaseRoom
class_name CombatRoom

var combat_node: CombatNode
var enemy_factory: EnemyFactory = EnemyFactory.new()
var enemies:Dictionary[int,Enemy]

const enemy_scene = preload("res://Scenes/Enemys/enemy.tscn")

func setup(map_node:MapNode) -> void:
	var enemy_id:int = 0
	var enemy:Enemy
	super(map_node)
	combat_node = map_node as CombatNode
	for enemy_name in combat_node.enemies:
		enemy = null
		enemy = enemy_scene.instantiate() as Enemy
		add_child(enemy)
		enemy = enemy_factory.create_enemy(enemy_name,enemy,enemy_id)
		enemies.set(enemy.id,enemy)
		#enemies.append(enemy_factory.create_enemy(enemy_name,enemy))#
	#enemies.get(1).initial_position(340,360) hay que variar las posiciones de los enemigos
	_combat_flow()

func _combat_flow():
	_show_dialogue(combat_node.start_dialogue)
	_combat()
	_show_dialogue(combat_node.end_dialogue)

func _show_dialogue(dialogue: Array):
	pass

func _combat():
	pass

func _lost():
	pass

func _win():
	pass
	
func damage_enemy(damage:int,enemy_id):
	var enemy_damaged = enemies.get(enemy_id)
	enemy_damaged.update_life(damage)
	if (enemy_damaged.life_value <= 0):
		enemy_damaged.free()
