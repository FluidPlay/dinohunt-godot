extends Node

signal on_set_health
signal on_add_score

@export var P1Health_label:RichTextLabel
@export var P2Health_label:RichTextLabel

@export var P1Score_label:RichTextLabel
@export var P2Score_label:RichTextLabel

var P1Score:int = 0
var P2Score:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_set_health.connect(set_health)
	on_add_score.connect(add_score)
	
func set_health(newHealth, pNumber):
	if (pNumber == 0):
		P1Health_label.text = "Health: "+str(newHealth)
		
func add_score(points, pNumber):
	if (pNumber == 0):
		P1Score += points
		P1Score_label.text = "Score: "+str(P1Score)
