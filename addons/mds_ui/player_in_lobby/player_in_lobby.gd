class_name PlayerInLobby extends GridContainer

var loading_image: CompressedTexture2D = preload("res://addons/mds_ui/icons/loading_arrows.png")
var synced_image: CompressedTexture2D = preload("res://addons/mds_ui/icons/checkmark.png")

@export var player_id: int = 1
@export var player_name: String = "Default Player Name":
	set(new_player_name):
		player_name = new_player_name
		%PlayerName.text = new_player_name
@export var is_synced: bool = false:
	set(new_is_synced):
		is_synced = new_is_synced
		if is_synced:
			%PlayerSyncStatus.texture = synced_image
		else:
			%PlayerSyncStatus.texture = loading_image

func _ready() -> void:
	%PlayerName.text = player_name
