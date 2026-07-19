extends CanvasLayer

class_name EventDialog

@export var trigger_sound = preload("res://Sounds/Effects/popup.mp3")
@export var lore_images_path: String = ""
@export var event_text: RichTextLabel
@export var event_illustration: TextureRect

signal dialog_closed()

func setup(lore_node: LoreNode):
	event_text.text = lore_node.lore_script
	event_illustration.texture = load(lore_images_path + lore_node.lore_image_path)
	$PopupSound.stream = trigger_sound
	$PopupSound.play()

func _on_close_button_down():
	dialog_closed.emit()
	queue_free()
