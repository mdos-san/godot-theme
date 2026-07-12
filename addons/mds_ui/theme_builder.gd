@tool
class_name ThemeBuilder extends Node

@export var sprite_size: int = 192
@export var margin_size: int = 24
@onready @export var atlas_sprite: Texture2D = load("res://addons/mdossan_theme/theme.png"):
	set(new_atlas):
		print("Atlas has been loaded")
		atlas_sprite = new_atlas
@export_tool_button("Build Theme", "Callable") var button = build

func build() -> void:
	print("Starting theme build")
	var theme_elements = ["primary", "hover", "selected", "disabled"]
	for i in len(theme_elements):
		var element_name = theme_elements[i]
		var atlas_texture = AtlasTexture.new()
		atlas_texture.atlas = atlas_sprite
		atlas_texture.region = Rect2(sprite_size * i, 0, sprite_size, sprite_size)
		DirAccess.remove_absolute("res://addons/mdossan_theme/%s.tres" % element_name)
		ResourceSaver.save(atlas_texture, "res://addons/mdossan_theme/%s.tres" % element_name)
		var style_box: StyleBoxTexture = ResourceLoader.load("res://addons/mdossan_theme/%s_box.tres" % element_name)
		style_box.texture_margin_bottom = margin_size
		style_box.texture_margin_left = margin_size
		style_box.texture_margin_top = margin_size
		style_box.texture_margin_right = margin_size
	EditorInterface.get_resource_filesystem().scan()
	print("Theme is builded")
