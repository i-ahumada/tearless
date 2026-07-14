extends TextEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "100%"

func _on_text_changed(new_percent:String) -> void:
	text = new_percent
