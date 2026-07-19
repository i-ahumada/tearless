extends CanvasLayer

class_name LoseScreen

signal change_game_state(new_state: Game.GameState)

func _on_back_to_menu_button_down():
	change_game_state.emit(Game.GameState.MENU)

func _on_restart_button_down():
	change_game_state.emit(Game.GameState.PLAY)
