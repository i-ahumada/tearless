extends MarginContainer


signal direction_button_clicked(direction: GameEnums.Directions)

@export var tearComponent: TextureProgressBar
@export var tearPercentage: Label

func _ready():
	update_life(100.0)

func update_life(percentage: float):
	tearComponent.value = percentage
	tearPercentage.text = str(percentage)+"%"

func _on_button_change_room(direction: GameEnums.Directions):
	direction_button_clicked.emit(direction)
