extends Control


func _on_order_spawner_display_score(score: int) -> void:
	$score_label.text = str("Score: ", score)
