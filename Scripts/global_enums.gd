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
	MOVEMENT
}

enum Enemies {
	SPIDER,
}

enum Skills {
	ATTACK,
	DEFEND,
	ESCAPE,
	NONE
}
