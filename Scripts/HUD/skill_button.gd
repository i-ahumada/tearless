extends Button
class_name Skill_button

signal button_skill(skill: GameEnums.Skills)

@export var skill: GameEnums.Skills = GameEnums.Skills.NONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (skill == GameEnums.Skills.NONE):
		disable_icon()
	else:
		enable_icon()

func disable_icon():
	disabled = true

func enable_icon():
	disabled = false

func _on_button_down():
	assert(skill != GameEnums.Skills.NONE)
	button_skill.emit(skill)
	print("Skill enviada: ", skill)
