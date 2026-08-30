extends FallingItem

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player_node = body as Player
		
		player_node.hp -= 1
		
		if player_node.hp < 0:
			# ゲームオーバー処理の前にプレイヤーのテクスチャを更新
			player_node.update_status_and_score()
			get_tree().paused = true
			get_parent().get_parent().get_node("GameOverUI").show()
			
		queue_free()
