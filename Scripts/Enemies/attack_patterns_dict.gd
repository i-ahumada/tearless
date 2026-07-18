extends RefCounted

class_name AttackPatternsDict

enum AttackPatternsReference {
	COMMON_1 = 1,
	COMMON_2 = 2,
	COMMON_3 = 3,
}

const attack_patterns: Dictionary[AttackPatternsReference,Variant] = {
	AttackPatternsReference.COMMON_1: [
		GameEnums.EnemiesActions.ATTACK,
		GameEnums.EnemiesActions.NONE
	],
	AttackPatternsReference.COMMON_2: [
		GameEnums.EnemiesActions.ATTACK,
		GameEnums.EnemiesActions.NONE,
		GameEnums.EnemiesActions.NONE
	],
	AttackPatternsReference.COMMON_3: [
		GameEnums.EnemiesActions.ATTACK,
		GameEnums.EnemiesActions.NONE,
		GameEnums.EnemiesActions.ATTACK,
		GameEnums.EnemiesActions.ATTACK
	],
}
