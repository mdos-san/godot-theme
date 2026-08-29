class_name MdsLabel extends Label

func update_text(new_text: String) -> void:
	text = new_text
	pivot_offset = size / 2
	var tween: Tween = get_tree().root.create_tween()
	tween.tween_property(self, "scale", Vector2(1.4, 1.4), .04)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), .08)
