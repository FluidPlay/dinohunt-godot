extends Node

signal on_set_health

@export var P1Health_label:RichTextLabel
@export var P2Health_label:RichTextLabel

@export var P1Score_label:RichTextLabel
@export var P2Score_label:RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_set_health.connect(set_health)

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
	
func set_health(newHealth, pNumber):
	if (pNumber == 0):
		P1Health_label.text = "Health: "+str(newHealth)
