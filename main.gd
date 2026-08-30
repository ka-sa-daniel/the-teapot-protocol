extends Node

@onready var pause_menu_scene = preload("res://PauseMenu.tscn")
var is_paused = false
var current_pause_menu = null

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if is_paused:
			resume_game()
		else:
			pause_game()

func pause_game():
	is_paused = true
	get_tree().paused = true
	current_pause_menu = pause_menu_scene.instantiate()
	add_child(current_pause_menu)

func resume_game():
	is_paused = false
	get_tree().paused = false
	if current_pause_menu:
		current_pause_menu.queue_free()
		current_pause_menu = null
