extends Node

signal on_load_scene
#@export var scene_to_load: PackedScene
@export var scene_name: String = "game"

func _ready() -> void:
	on_load_scene.connect(load_scene)

func load_scene() -> void:
	if !scene_name == "":
		SceneSwitcher.switch_scene("res://GameScenes/"+scene_name+".tscn")
