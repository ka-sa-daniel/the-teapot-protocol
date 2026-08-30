extends Control

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_return_to_title_button_pressed():
	# ゲームの一時停止状態を解除
	get_tree().paused = false
	# スタート画面のシーンに切り替える
	get_tree().change_scene_to_file("res://StartScreen.tscn")
