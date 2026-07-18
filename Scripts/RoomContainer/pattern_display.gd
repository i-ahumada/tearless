extends CanvasLayer

class_name PatternDisplay

@export var attack_icon: Resource = preload("res://Sprites/Combat/attack_pattern_display.png")
@export var none_icon: Resource = preload("res://Sprites/Combat/none_pattern_display.png")
@onready var pattern_display_container: HBoxContainer = $Control/PanelContainer/PatternDisplayContainer
var patterns_to_display: Array[Array] = []

func add_pattern(pattern: Array[GameEnums.EnemiesActions]):
	patterns_to_display.push_back(pattern)

func display():
	for pattern in patterns_to_display:
		for action in pattern:
			var pattern_icon = TextureRect.new()
			pattern_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			pattern_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			pattern_icon.custom_minimum_size = Vector2(64, 64)
			pattern_icon.size = Vector2(64,64)
			if (action == GameEnums.EnemiesActions.ATTACK):
				pattern_icon.texture = attack_icon
			else:
				pattern_icon.texture = none_icon

			pattern_display_container.add_child(pattern_icon)
	await get_tree().create_timer(3).timeout
	queue_free()
