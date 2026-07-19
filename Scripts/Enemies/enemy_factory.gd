extends Node
class_name EnemyFactory


@export var spider_route = "res://Sprites/Characters/Enemies/spider.png"
@export var zombie_route = "res://Sprites/Characters/Enemies/zombie.png"

func create_enemy(type:GameEnums.Enemies, enemy:Enemy, id) -> Enemy:
	match type:
		GameEnums.Enemies.SPIDER:
			enemy.setup(50,spider_route,id,5)
			enemy.set_attack_pattern([
				AttackPatternsDict.AttackPatternsReference.COMMON_1,
				AttackPatternsDict.AttackPatternsReference.COMMON_2,
				AttackPatternsDict.AttackPatternsReference.COMMON_3
			].pick_random())
		GameEnums.Enemies.ZOMBIE:
			enemy.setup(40,zombie_route,id,7)
			enemy.set_attack_pattern([
				AttackPatternsDict.AttackPatternsReference.COMMON_1,
				AttackPatternsDict.AttackPatternsReference.COMMON_2,
				AttackPatternsDict.AttackPatternsReference.COMMON_3
			].pick_random())
	return enemy
