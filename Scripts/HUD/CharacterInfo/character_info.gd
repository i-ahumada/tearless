extends MarginContainer


signal direction_button_clicked(direction: GameEnums.Directions)
signal skill_button_clicked(skill: GameEnums.Skills)

@export var tear_component: TextureProgressBar
@export var tear_percentage: Label
@export var dialogue_label: Label
@export var direction_buttons_dict: Dictionary[GameEnums.Directions,DirectionButton]
@export var dialogue_timer_time: float = 2.
@export var skill_buttons: Array[SkillButton]

func _ready():
	update_life(100.0)

func update_life(percentage: float):
	tear_component.value = percentage
	tear_percentage.text = str(percentage)+"%"

func set_dialogue(dialogue):
	for dialogue_text in dialogue:
		dialogue_label.text = dialogue_text
		await get_tree().create_timer(dialogue_timer_time).timeout
	dialogue_label.text = '...'

func disable_all_directions():
	for direction in direction_buttons_dict:
		direction_buttons_dict[direction].disabled = true

func enable_only_valid_directions(map_node: MapNode):
	for direction in map_node.node_directions:
		direction_buttons_dict[direction].disabled = map_node.node_directions[direction] == null

func disable_skills():
	for skill_button in skill_buttons:
		skill_button.disabled = true

func enable_skills():
	for skill_button in skill_buttons:
		skill_button.disabled = false


func _on_button_change_room(direction: GameEnums.Directions):
	direction_button_clicked.emit(direction)


func _on_button_skill(skill: GameEnums.Skills) -> void:
	skill_button_clicked.emit(skill)
