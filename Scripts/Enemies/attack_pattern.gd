extends RefCounted

class_name AttackPattern

var pattern: Array = []
var attack_queue: Array[GameEnums.EnemiesActions] = []

func _init(attack_key: AttackPatternsDict.AttackPatternsReference):
	pattern = AttackPatternsDict.attack_patterns[attack_key]
	_fill_queue()

func _fill_queue():
	for action in pattern:
		attack_queue.push_back(action)

func next_attack()-> GameEnums.EnemiesActions:
	var enemy_action: GameEnums.EnemiesActions = attack_queue.pop_front()
	attack_queue.push_back(enemy_action)
	return enemy_action
