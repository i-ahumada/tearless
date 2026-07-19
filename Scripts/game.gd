extends Node

class_name Game


@onready var game_scene: PackedScene = preload("res://Scenes/GameController/game_controller.tscn")
@onready var lose_screen_scene: PackedScene = preload("res://Scenes/lose_screen.tscn")
@onready var menu_screen_scene: PackedScene = preload("res://Scenes/menu.tscn")
@onready var end_screen_scene: PackedScene = preload("res://Scenes/end_screen.tscn")

var state_scene_instance = null

enum GameState {
	END,
	LOSE,
	PLAY,
	MENU
}

var state: GameState = GameState.MENU

func _ready():
	_on_change_game_state(GameState.MENU)

func _on_change_game_state(new_state: GameState):
	state = new_state

	if (state_scene_instance):
		state_scene_instance.queue_free()

	match state:
		GameState.END:
			state_scene_instance = end_screen_scene.instantiate() as EndScreen
		GameState.LOSE:
			state_scene_instance = lose_screen_scene.instantiate() as LoseScreen
		GameState.PLAY:
			state_scene_instance = game_scene.instantiate() as GameController
		GameState.MENU:
			state_scene_instance = menu_screen_scene.instantiate() as Menu

	state_scene_instance.change_game_state.connect(_on_change_game_state)
	add_child(state_scene_instance)
