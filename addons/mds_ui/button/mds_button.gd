class_name MdsButton extends Button

@export var audio_hover: AudioStream
@export var audio_click: AudioStream

func _ready() -> void:
	pivot_offset = size / 2
	%AudioHover.stream = audio_hover
	%AudioClick.stream = audio_click

func _on_mouse_entered() -> void:
	if disabled:
		return

	if audio_hover:
		%AudioHover.play(0.0)

	var tween: Tween = get_tree().root.create_tween()
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), .04)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), .08)

func _on_mouse_exited() -> void:
	if disabled:
		return

	var tween: Tween = get_tree().root.create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), .1)

func _on_button_down() -> void:
	if disabled:
		return

	if audio_click:
		%AudioClick.play(0.0)
	var tween: Tween = get_tree().root.create_tween()
	tween.tween_property(self, "scale", Vector2(.9, .9), .04)
