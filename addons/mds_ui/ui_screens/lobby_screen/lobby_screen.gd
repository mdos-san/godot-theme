class_name LobbyScreen extends CenterContainer

signal ui_game_started

var SCREEN_ID: String = "LOBBY"

@export var mds_webrtc_bridge: MdsWebRtcBridge = preload("res://addons/mds_webrtc/mds_webrtc_bridge.tres")
@export var game_bridge: GameBridge = preload("res://src/game/game_bridge.tres")
@export var screen_resource: UIScreenResource = preload("res://addons/mds_ui/ui_screens/main_screen_resource.tres")
@export var player_in_lobby_scene: PackedScene = preload("res://addons/mds_ui/player_in_lobby/player_in_lobby.tscn")

func _ready() -> void:
	screen_resource.transition_requested.connect(on_screen_transition)
	on_screen_transition(screen_resource.current_screen_id)
	mds_webrtc_bridge.changed.connect(on_lobby_data_changed)

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

func on_lobby_data_changed() -> void:
	%StartButton.visible = mds_webrtc_bridge.is_host

	for child in %PlayersInLobby.get_children():
		child.queue_free()

	for player_id: int in mds_webrtc_bridge.player_names_by_player_ids:
		var player_name: String = mds_webrtc_bridge.player_names_by_player_ids[player_id]
		var player_in_lobby: PlayerInLobby = player_in_lobby_scene.instantiate()
		player_in_lobby.player_id = player_id
		player_in_lobby.player_name = player_name
		player_in_lobby.is_synced = mds_webrtc_bridge.ready_players.has(player_id)
		%PlayersInLobby.add_child(player_in_lobby)

func _on_start_button_pressed() -> void:
	game_bridge.game_start_requested.emit()
