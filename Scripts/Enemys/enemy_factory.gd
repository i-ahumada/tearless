extends Node
class_name EnemyFactory

func create_enemy(type:GameEnums.Enemies) -> Enemy:
	var enemy: Enemy = null
	
	match type:
		GameEnums.Enemies.SPIDER:
			enemy = Enemy.new(100)
			# enemy.set_attack_pattern()
	return enemy
