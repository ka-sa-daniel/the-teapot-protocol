extends Node2D

@onready var raindrop_scene = preload("res://CoffeeDrop.tscn")
@onready var teadrop_scene = preload("res://TeaDrop.tscn")
@onready var tealeaf_scene = preload("res://TeaLeaf.tscn")
@onready var screen_width = get_viewport_rect().size.x
var timer = 0.0
var spawn_interval = 0.5
var tealeaf_spawn_chance = 0.1

func _process(delta):
	timer += delta
	if timer >= spawn_interval:
		spawn_raindrop()
		timer = 0.0

func spawn_raindrop():
	var fall_speed = 0
	if Global.difficulty == "easy":
		fall_speed = 300
	elif Global.difficulty == "normal":
		fall_speed = randf_range(300, 500)
	elif Global.difficulty == "hard":
		fall_speed = randf_range(400, 600)
	
	var selected_scene = raindrop_scene
	
	if randf() < tealeaf_spawn_chance:
		selected_scene = tealeaf_scene
	elif Global.is_tea_rain:
		selected_scene = teadrop_scene
	else:
		selected_scene = raindrop_scene
	
	var new_raindrop = selected_scene.instantiate()
	add_child(new_raindrop)
	
	new_raindrop.position.x = randf_range(0, screen_width)
	new_raindrop.position.y = -50
	
	# インスタンス化したノードの落下速度を設定
	if new_raindrop.has_method("set_fall_speed"):
		new_raindrop.set_fall_speed(fall_speed)
	else:
		new_raindrop.fall_speed = fall_speed
