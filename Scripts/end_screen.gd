extends CanvasLayer

class_name EndScreen

signal change_game_state(new_state: Game.GameState)

@onready var menu_button: Button = $BackToMenuButton



func _on_back_to_menu_button_down() -> void:
	change_game_state.emit(Game.GameState.MENU)
