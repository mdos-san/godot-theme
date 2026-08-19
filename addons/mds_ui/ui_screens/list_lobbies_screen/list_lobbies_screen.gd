extends CenterContainer

signal ui_lobby_join_requested(lobby_id: String)

var SCREEN_ID: String = "LIST_LOBBIES"

@export var list_lobby_data: MdsAvailableLobbiesState = preload("res://addons/mds_webrtc/mds_available_lobbies_state.tres")
@export var screen_resource: UIScreenResource = preload("res://addons/mds_ui/ui_screens/main_screen_resource.tres")

var mds_button_scene: PackedScene = preload("res://addons/mds_ui/button/mds_button.tscn")

func _ready() -> void:
	screen_resource.transition_requested.connect(on_screen_transition)
	on_screen_transition(screen_resource.current_screen_id)
	list_lobby_data.changed.connect(on_list_lobby_data)

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

func _on_back_pressed() -> void:
	screen_resource.transition_requested.emit("MAIN")

func on_list_lobby_data() -> void:
	for child in %LobbiesAvailable.get_children():
		child.queue_free()

	for lobby in list_lobby_data.lobbies:
		var lobby_id: String = lobby["lobbyId"]
		var lobby_name: String = lobby["lobbyName"]
		var button: MdsButton = mds_button_scene.instantiate()
		button.text = lobby_name
		button.pressed.connect(func(): 
			ui_lobby_join_requested.emit(lobby_id)
			screen_resource.request_transition("LOBBY")
		)
		%LobbiesAvailable.add_child(button)
