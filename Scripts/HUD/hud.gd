extends CanvasLayer

signal direction_button_clicked(direction: GameEnums.Directions)

func _on_character_info_direction_button_clicked(direction):
	direction_button_clicked.emit(direction)
