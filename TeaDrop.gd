extends FallingItem

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# 体力が最大値（2）未満の場合のみ回復
		if body.hp < 2:
			body.hp += 1
		
		# 衝突後、自身を消す
		queue_free()
