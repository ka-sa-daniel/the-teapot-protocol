class_name FallingItem
extends Area2D

@export var fall_speed: float = 300.0

func _process(delta):
	position.y += fall_speed * delta

	var screen_height = get_viewport_rect().size.y
	if position.y > screen_height + 50:
		queue_free()
