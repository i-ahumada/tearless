extends Control

class_name MapRoomCell

@export var icon: Resource
@export var background: Color
@export var id: int
@export var current: bool = false
var neighbours: Array[int]

func setup(node_id, node_icon, node_background, node_directions):
	current = false
	icon = node_icon
	background = node_background
	id = node_id

	for direction in node_directions:
		if (node_directions[direction]):
			neighbours.push_back(node_directions[direction].id)
			match direction:
				GameEnums.Directions.LEFT:
					$Left.visible = true
					$Left.color = background
				GameEnums.Directions.RIGHT:
					$Right.visible = true
					$Right.color = background
				GameEnums.Directions.UP:
					$Up.visible = true
					$Up.color = background
				GameEnums.Directions.DOWN:
					$Down.visible = true
					$Down.color = background

	$Background.color = background
	$Icon.texture = icon

func clear_icon():
	icon = null
	$Icon.texture = null

func hint():
	visible = true
	modulate = Color(.3,.3,.3,1)

func visit():
	current = true
	visible = true
	modulate = Color(2.0, 2.0, 2.0, 1)

func leave():
	current = false
	modulate = Color(0.75, 0.75, 0.75, 1)
