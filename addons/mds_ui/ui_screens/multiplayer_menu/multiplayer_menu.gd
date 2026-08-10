extends CenterContainer

signal player_name_changed(new_player_name: String)
signal lobby_creation_requested
signal lobbies_list_requested

static var SCREEN_ID: String = "MULTIPLAYER"

@export var screen_resource: UIScreenResource = preload("res://addons/mds_ui/ui_screens/main_screen_resource.tres")

func _ready() -> void:
	screen_resource.transition_requested.connect(on_screen_transition)
	on_screen_transition(screen_resource.current_screen_id)

func on_screen_transition(new_screen_id: String) -> void:
	var should_display = new_screen_id == SCREEN_ID
	var TRANSITION_DURATION: float = .2
	if not should_display:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(-1200, 0), TRANSITION_DURATION)
		tween.tween_property(self, "visible", false, 0)
	else:
		position = Vector2(1200, 0)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "visible", true, 0)
		tween.tween_property(self, "position", Vector2(0, 0), TRANSITION_DURATION)

func _on_create_lobby_button_pressed() -> void:
	screen_resource.request_transition("LOBBY")
	lobby_creation_requested.emit()

func _on_join_lobby_button_pressed() -> void:
	screen_resource.request_transition("LIST_LOBBIES")
	lobbies_list_requested.emit()

func _on_options_button_pressed() -> void:
	screen_resource.request_transition("OPTIONS")

func _on_player_name_changed(new_player_name: String) -> void:
	player_name_changed.emit(new_player_name)

	if new_player_name == "":
		%CreateLobbyButton.disabled = true
		%JoinLobbyButton.disabled = true
		return

	%CreateLobbyButton.disabled = false
	%JoinLobbyButton.disabled = false

func _on_mouse_entered_button() -> void:
	%HoverAudio.play()

func _on_click_button() -> void:
	%ClickAudio.play()
