extends Control

class_name MapRoomCell

@export var icon: Resource
@export var background: Color = Color("858f97")
@export var id: int
@export var current: bool = false
var neighbours: Array[int]

func setup(node_id, node_icon, node_directions):
	current = false
	icon = node_icon
	id = node_id

	for direction in node_directions:
		if (node_directions[direction]):
			neighbours.push_back(node_directions[direction].id)
			match direction:
				GameEnums.Directions.LEFT:
					$Left.visible = true
					$Left.color = Color("576373")
				GameEnums.Directions.RIGHT:
					$Right.visible = true
					$Right.color = Color("576373")
				GameEnums.Directions.UP:
					$Up.visible = true
					$Up.color = Color("576373")
				GameEnums.Directions.DOWN:
					$Down.visible = true
					$Down.color = Color("576373")

	$Background.color = background
	$Icon.texture = icon

func color_directions(color: Color):
	$Left.color = color
	$Right.color = color
	$Up.color = color
	$Down.color = color


func clear_icon():
	icon = null
	$Icon.texture = null

func hint():
	visible = true
	$Background.color = Color("323859")
	color_directions(Color("323859"))

func visit():
	current = true
	visible = true
	$Background.color = Color("ecfffb")
	color_directions(Color("ecfffb"))

func leave():
	current = false
	$Background.color = Color("576373")
	color_directions(Color("576373"))
