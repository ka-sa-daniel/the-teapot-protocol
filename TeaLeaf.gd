class_name TeaLeaf
extends FallingItem

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player_node = body as Player
		player_node.start_status_timer(5.0) # Playerのタイマー開始関数を呼び出す
		
		queue_free()
