extends SkillButton

@export var opened_eye: Resource = null
@export var closed_eye: Resource = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (skill == GameEnums.Skills.NONE):
		disabled = true
	else:
		disabled = false
		open_eye()


func open_eye():
	icon = opened_eye

func close_eye():
	icon = closed_eye


func _on_pressed() -> void:
	if (icon == closed_eye):
		return
	close_eye()
	disabled = true
	await get_tree().create_timer(2.0).timeout
	disabled = false
	open_eye()
