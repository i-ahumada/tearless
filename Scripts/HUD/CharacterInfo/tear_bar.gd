extends TextureProgressBar


func _ready() -> void:
	value = 100

func _on_value_changed(value_changed: float) -> void:
	value = value_changed
