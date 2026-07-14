extends MapNode

class_name LoreNode

var lore_script: String # Maybe it should be a reference to where the script is stored
var lore_image_path: String

func _init(node_data: Dictionary):
	super(node_data)
	lore_image_path = node_data["image_path"]
	lore_script = node_data["lore_script"]
