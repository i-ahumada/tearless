extends Button
class_name DirectionButton

signal button_change_room(direction: GameEnums.Directions)

@export var direction: GameEnums.Directions = GameEnums.Directions.NONE;

func _ready():
	if (direction == GameEnums.Directions.NONE):
		disabled = true

func _on_button_down():
	assert(direction != GameEnums.Directions.NONE)
	button_change_room.emit(direction)
	print("direction emitted: ", direction)
