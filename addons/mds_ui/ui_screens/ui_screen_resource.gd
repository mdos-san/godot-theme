class_name UIScreenResource extends Resource

@export var current_screen_id: String = "MAIN"

signal transition_requested(new_screen_id: String)
func request_transition(new_screen_id: String) -> void:
	current_screen_id = new_screen_id
	transition_requested.emit(new_screen_id)
