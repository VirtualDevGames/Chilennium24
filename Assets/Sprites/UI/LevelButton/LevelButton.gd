extends TextureButton
class_name LevelSelectButton

@onready var label = $Label
@onready var sfx_menu_select = $"MenuSound"
@export var level_name : String = ""

@export_file var level_path

var transitioning = true


func _ready():
	if level_name:
		label.text = level_name
	TransitionSignals.FadeToClearFinished.connect(SetTransitioning)
	
func _on_button_up():
	if level_path == null:
		print("path null")
		return
	sfx_menu_select.play()
	TransitionSignals.TransitionButtonPressed.emit(level_path)

func SetTransitioning():
	transitioning = false
