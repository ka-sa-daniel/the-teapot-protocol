extends Control

@onready var main_menu = $MainMenu
@onready var difficulty_menu = $DifficultyMenu
@onready var animation_player = $AnimationPlayer
@onready var lid = $Lid

func _ready():
	difficulty_menu.hide()
	
	# 蓋の初期位置と表示状態を明示的に設定
	# XとYの値は、スタート画面のTeapotの蓋の位置に合わせてください
	lid.position = Vector2(1000, 400) 
	lid.visible = true

func _on_start_delay_timer_timeout():
	if animation_player:
		animation_player.play("LidThrow")

func _on_start_button_pressed():	
	main_menu.hide()
	difficulty_menu.show()

func _on_exit_button_pressed():
	get_tree().quit()

func _on_difficulty_back_button_pressed():
	difficulty_menu.hide()
	main_menu.show()

func _on_full_button_pressed():
	Global.difficulty = "easy"
	get_tree().change_scene_to_file("res://main.tscn")

func _on_half_full_button_pressed():
	Global.difficulty = "normal"
	get_tree().change_scene_to_file("res://main.tscn")

func _on_empty_button_pressed():
	Global.difficulty = "hard"
	get_tree().change_scene_to_file("res://main.tscn")
