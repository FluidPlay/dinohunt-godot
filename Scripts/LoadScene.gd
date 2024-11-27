extends Node

signal on_load_scene
@export var scene_to_load: PackedScene

func _ready() -> void:
	on_load_scene.connect(load_scene)

func load_scene() -> void:
	if !scene_to_load == null:
		SceneSwitcher.switch_scene(scene_to_load.resource_path)
