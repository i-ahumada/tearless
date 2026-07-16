extends Button
class_name DirectionButton

signal button_change_room(direction: GameEnums.Directions)

@export var direction: GameEnums.Directions = GameEnums.Directions.NONE;
@export var disabled_icon: Resource = null
@export var active_icon: Resource = null

func _ready():
	if (direction == GameEnums.Directions.NONE):
		disable_button()
	else:
		activate_icon()

func activate_icon():
	disabled = false
	icon = active_icon

func disable_button():
	disabled = true
	icon = disabled_icon

func _on_button_down():
	assert(direction != GameEnums.Directions.NONE)
	button_change_room.emit(direction)
