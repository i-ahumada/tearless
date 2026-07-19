extends CanvasLayer

class_name Menu

signal change_game_state(new_state: Game.GameState)

func _on_start_button_down():
	change_game_state.emit(Game.GameState.PLAY)

func _on_exit_button_down():
	get_tree().quit()
