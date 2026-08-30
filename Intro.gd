extends Control

@onready var image1 = $Image1
@onready var image2 = $Image2
@onready var image3 = $Image3
@onready var image4 = $Image4
@onready var image5 = $Image5
@onready var image6 = $Image6
@onready var timer = $Timer

var images = []
var current_image_index = 0

func _ready():
	images = [image1, image2, image3, image4, image5, image6]
	
	# すべての画像を非表示にする
	for img in images:
		img.visible = false
	
	# 最初の画像を表示
	if not images.is_empty():
		images[current_image_index].visible = true
		# 最初のタイマーは通常通り3秒に設定
		timer.start(3.0)

func _on_timer_timeout():
	# 現在の画像を非表示にする
	images[current_image_index].visible = false
	
	current_image_index += 1
	
	if current_image_index < images.size():
		# 次の画像を表示する
		images[current_image_index].visible = true
		
		# image3 (インデックス2) から image4 (インデックス3) への切り替え時のみ時間を変更
		if current_image_index == 2:
			timer.wait_time = 1.0
		else:
			timer.wait_time = 3.0
			
		timer.start()
	else:
		# すべての画像を表示し終わったら、スタート画面に遷移
		get_tree().change_scene_to_file("res://StartScreen.tscn")

func _on_skip_button_pressed():
	get_tree().change_scene_to_file("res://StartScreen.tscn")
