extends Area2D
class_name ClickableArea2D

signal area_clicked

var mouse_inside = false

func _on_mouse_entered():
	mouse_inside = true

func _on_mouse_exited():
	mouse_inside = false

func _input(event):
	if mouse_inside:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			area_clicked.emit()
