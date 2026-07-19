extends RefCounted
class_name GameEnums

enum Directions {
	LEFT,
	UP,
	DOWN,
	RIGHT,
	NONE
}

enum NodeType {
	COMBAT,
	LORE,
	ITEM, # Optional
	EMPTY,
	NEXT_LEVEL,
	END,
}

enum NodeState {
	ACTION,
	MOVEMENT,
	COMBAT
}

enum EnemiesActions {
	ATTACK,
	NONE
}

enum CombatTurn {
	PLAYER,
	ENEMY
}

enum Enemies {
	SPIDER,
	ZOMBIE,
	GHOST
}

enum Skills {
	ATTACK,
	DEFEND,
	ESCAPE,
	NONE
}
