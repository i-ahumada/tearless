extends TextureProgressBar


func _ready() -> void:
	value = 100

func _on_value_changed(new_value: float) -> void:
	value = new_value
