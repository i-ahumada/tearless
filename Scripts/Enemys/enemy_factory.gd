extends Node
class_name EnemyFactory


var spider_route = "res://Sprites/Characters/Enemys/spider.png"
var zombie_route = "res://Sprites/Characters/Enemys/zombie.png"

func create_enemy(type:GameEnums.Enemies, enemy:Enemy, id) -> Enemy:
	match type:
		GameEnums.Enemies.SPIDER:
			enemy.setup(50,spider_route,id)
		GameEnums.Enemies.ZOMBIE:
			enemy.setup(40,zombie_route,id)
			enemy.initial_position(340,360)
	return enemy 
