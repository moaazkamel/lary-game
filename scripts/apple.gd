extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.apples_collected += 1
		print("+1 apple | total: ", GameManager.apples_collected)
		queue_free()

		if GameManager.apples_collected >= GameManager.apples_needed:
			get_tree().change_scene_to_file(GameManager.next_level_path)
