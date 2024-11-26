extends Button

@export var input_action_id : String = "ui_accept"

func _input(_event):
	if Input.is_action_just_pressed(input_action_id):
		print("Space key pressed")
		pressed.emit()

#func _ready() -> void:
	#pressed.connect(button_pressed)
	
#func button_pressed() -> void:
	#pass		
