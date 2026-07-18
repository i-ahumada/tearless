extends RefCounted

class_name AttackPatternsDict

enum AttackPatternsReference {
	COMMON_1 = 1,
	COMMON_2 = 2,
	COMMON_3 = 3,
}

const attack_patterns: Dictionary[AttackPatternsReference,Array] = {
	AttackPatternsReference.COMMON_1: [1,0],
	AttackPatternsReference.COMMON_2: [1,0,0],
	AttackPatternsReference.COMMON_3: [1,0,1,1],
}
