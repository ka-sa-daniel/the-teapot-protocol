class_name Player
extends CharacterBody2D

const SPEED_FULL = 100
const SPEED_HALF = 200
const SPEED_EMPTY = 300
@onready var sprite = $Sprite2D
@onready var status_label = get_node("/root/main/StatusLabel")
@onready var score_label = get_node("/root/main/ScoreLabel")
@onready var status_code_message_label = get_node("/root/main/StatusCodeMessageLabel")
@onready var status_timer_bar = get_node("/root/main/StatusCodeTimer")
var status_value = 418
var score_value = 0
var hp = 2
var teapot_empty_texture = preload("res://images/teapot_empty.png")
var teapot_half_full_texture = preload("res://images/teapot_half_full.png")
var teapot_full_texture = preload("res://images/teapot_full.png")
var teapot_damaged_texture = preload("res://images/teapot_damaged.png")
var current_status_timer = 0.0
var previous_status = 418
var is_status_overridden = false

func _ready():
	var screen_size = get_viewport_rect().size
	var scaled_sprite_height = sprite.texture.get_height() * sprite.scale.y
	position.y = screen_size.y - scaled_sprite_height / 2
	position.x = screen_size.x / 2
	

	# 難易度に応じて初期体力を設定
	if Global.difficulty == "hard":
		hp = 0
	elif Global.difficulty == "normal":
		hp = 1
	elif Global.difficulty == "easy":
		hp = 2

	status_timer_bar.hide()
	update_status_and_score()

func _physics_process(delta):
	var direction_x = Input.get_axis("ui_left", "ui_right")
	
	var current_speed = 0
	if hp == 2:
		current_speed = SPEED_FULL
	elif hp == 1:
		current_speed = SPEED_HALF
	elif hp == 0 or hp < 0:
		current_speed = SPEED_EMPTY
	else:
		current_speed = SPEED_EMPTY
	
	velocity.x = direction_x * current_speed
	move_and_slide()

	if direction_x > 0:
		sprite.flip_h = true
	elif direction_x < 0:
		sprite.flip_h = false

func _process(delta):
	score_value += int(delta * 100)
	
	if is_status_overridden:
		current_status_timer -= delta
		if current_status_timer <= 0:
			is_status_overridden = false
			status_value = previous_status
			status_timer_bar.hide()
	
	status_timer_bar.value = current_status_timer
	
	update_status_and_score()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		status_value = 503
		update_status_and_score()
		
func start_status_timer(timer_duration: float):
	if status_value != 200:
		previous_status = status_value
	
	status_value = 200
	is_status_overridden = true
	current_status_timer = timer_duration
	status_timer_bar.show()

func update_status_and_score():
	status_label.text = "STATUS: %d" % status_value
	score_label.text = "SCORE: %d" % score_value
	
	if hp < 0:
		sprite.texture = teapot_damaged_texture
	elif hp == 0:
		sprite.texture = teapot_empty_texture
	elif hp == 1:
		sprite.texture = teapot_half_full_texture
	else:
		sprite.texture = teapot_full_texture
	
	if status_value == 200:
		Global.is_tea_rain = true
	else:
		Global.is_tea_rain = false
	
	var background_node = get_node("/root/main/Background")
	if background_node:
		if status_value == 503:
			background_node.color = Color.BLACK
		else:
			background_node.color = Color.WHITE
			
	if status_value == 200:
		status_code_message_label.text = "OK"
	elif status_value == 400:
		status_code_message_label.text = "Bad Request"
	elif status_value == 418:
		status_code_message_label.text = "I'm a teapot"
	elif status_value == 500:
		status_code_message_label.text = "Internal Server Error"
	elif status_value == 503:
		status_code_message_label.text = "Service Unavailable"
	else:
		status_code_message_label.text = ""
