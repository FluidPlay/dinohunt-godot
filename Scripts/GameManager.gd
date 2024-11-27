extends Node

signal on_set_health
signal on_add_score
signal on_start_game

@export var P1Health_label: RichTextLabel
@export var P2Health_label: RichTextLabel

@export var P1Score_label: RichTextLabel
@export var P2Score_label: RichTextLabel

@export var intro_scene_name: String = "intro"
@export var game_scene_name: String = "game"

enum reload_scene_options { intro_scene, game_scene }
@export var reload_scene_on_death: reload_scene_options
@export var reload_scene_delay:float = 3.0

var P1Score:int = 0
var P2Score:int = 0

var instance = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_set_health.connect(set_health)
	on_add_score.connect(add_score)
	on_start_game.connect(start_game)
	instance = self
	
func start_game() -> void:
	if game_scene_name != "":
		#load_scene.call_deferred(game_scene)
		load_scene(game_scene_name)
	
func set_health(newHealth, pNumber):
	if (pNumber == 0):
		P1Health_label.text = "Health: "+str(newHealth)
		if newHealth <= 0:
			death()
			
func death():
	print("Died")
	get_tree().paused = true
	await get_tree().create_timer(reload_scene_delay).timeout
	print("Load next")
	var next_scene = intro_scene_name \
					 if reload_scene_on_death == reload_scene_options.intro_scene \
						else game_scene_name

	#load_scene.call_deferred(next_scene)
	load_scene(next_scene)
	get_tree().paused = false
	
func load_scene(next_scene):
	SceneSwitcher.switch_scene("res://GameScenes/"+next_scene+".tscn")
		
func add_score(points, pNumber):
	print("p number: "+str(pNumber))
	if (pNumber == 0):
		P1Score += points
		P1Score_label.text = "Score: "+str(P1Score)
