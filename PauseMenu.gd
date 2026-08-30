extends Control

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		get_parent().resume_game()

func _on_resume_button_pressed():
	get_parent().resume_game()

func _on_title_button_pressed():
	# ゲームの一時停止を解除し、タイトル画面に戻る
	get_tree().paused = false
	get_tree().change_scene_to_file("res://StartScreen.tscn")
