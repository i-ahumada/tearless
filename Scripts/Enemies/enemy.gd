extends Node2D
class_name Enemy

@export var life_value: int
@export var damage_value: int = 10
@onready var enemy_sprite:Sprite2D = $Area2D/CollisionShape2D/EnemySprite2D
@onready var left_up_corner:Sprite2D = $Area2D/CollisionShape2D/LeftUpCorner
@onready var right_up_corner:Sprite2D = $Area2D/CollisionShape2D/RightUpCorner
@onready var left_down_corner:Sprite2D = $Area2D/CollisionShape2D/LeftDownCorner
@onready var right_down_corner:Sprite2D = $Area2D/CollisionShape2D/RightDownCorner
@onready var enemy_area = $Area2D
@onready var blood_sprite:AnimatedSprite2D= $Area2D/CollisionShape2D/BloodSprite
@onready var enemy_collision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var life_bar:TextureProgressBar = $Area2D/TextureProgressBar
#--------shaking variables----------
var shake_intensity:float = 0.0
var active_shaking_time:float = 0.0
var shake_decay:float = 5.0
var shake_time:float = 0.0
var shake_time_speed:float = 20.0
var noise = FastNoiseLite.new()
var movement_2d: bool

signal enemy_selected(enemy_id)

var attack_pattern: AttackPattern
var dialogue: Array
var id

func setup(life_initial_value: int, icon_route:String, new_id, damage):
	life_value = life_initial_value
	id = new_id
	damage_value = damage
	enemy_sprite.texture = load(icon_route) as Texture2D
	enemy_collision.shape.set("size",enemy_sprite.texture.get_size())
	life_bar.max_value = life_initial_value
	setup_selected()
	blood_sprite.visible = false
	initial_position(640,360)
	_scale(4)

func set_attack_pattern(pattern: AttackPatternsDict.AttackPatternsReference):
	attack_pattern = AttackPattern.new(pattern)

func update_life(value:int):
	life_value += value
	life_bar.value += value

func initial_position(x_value:float,y_value:float):
	enemy_area.position.x = x_value
	enemy_area.position.y = y_value

func _scale(scale_value):
	enemy_area.scale.x = scale_value
	enemy_area.scale.y = scale_value

func get_action():
	return attack_pattern.next_attack()

func get_pattern():
	return attack_pattern.pattern

func setup_selected():
	var offset : int = 20
	left_down_corner.position = Vector2(-((enemy_sprite.texture.get_height()/2)-offset),(enemy_sprite.texture.get_height()/2)-offset)
	left_up_corner.position = Vector2(-((enemy_sprite.texture.get_height()/2)-offset),-((enemy_sprite.texture.get_height()/2)-offset))
	right_down_corner.position = Vector2((enemy_sprite.texture.get_width()/2)-offset,(enemy_sprite.texture.get_height()/2)-offset)
	right_up_corner.position = Vector2((enemy_sprite.texture.get_width()/2)-offset,-((enemy_sprite.texture.get_height()/2)-offset))

func unselect():
	left_down_corner.visible = false
	left_up_corner.visible = false
	right_down_corner.visible = false
	right_up_corner.visible = false

func select():
	left_down_corner.visible = true
	left_up_corner.visible = true
	right_down_corner.visible = true
	right_up_corner.visible = true

func _on_enemy_clicked():
	enemy_selected.emit(id)

func _physics_process(delta: float) -> void:
	if active_shaking_time > 0:
		shake_time += delta * shake_time_speed
		active_shaking_time -= delta
		
		if movement_2d:
			position = Vector2(
				noise.get_noise_2d(shake_time, 0) * shake_intensity,
				noise.get_noise_2d(0, shake_time) * shake_intensity)
		else:
			position = Vector2(
				noise.get_noise_2d(shake_time, 0) * shake_intensity,
				0)
		shake_intensity = max(shake_intensity - shake_decay * delta, 0)
		
	else:
		position = lerp(position, Vector2.ZERO, 10.5 * delta)
	
func enemy_shake(intensity:float,time:float):
	randomize()
	noise.seed = randi()
	noise.frequency = 2.0
	
	shake_intensity = intensity
	active_shaking_time = time
	shake_time = 0.0
	
func show_damage():
	movement_2d = true
	blood_sprite.visible = true
	blood_sprite.play("damage_splat")
	enemy_shake(9.0, 1.0)

func show_attack():
	movement_2d = false
	enemy_shake(15.0,1)
