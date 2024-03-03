extends TextureButton
class_name LevelSelectButton

@export var level_name : String = ""

@export_file var level_path

var transitioning = true
var can_press = true

func _ready():
	TransitionSignals.FadeToClearFinished.connect(SetTransitioning)
	
func _on_button_up():
	if level_path == null:
		print("path null")
		return
	#sfx_menu_select.play()
	if can_press:
		can_press = false
		TransitionSignals.TransitionButtonPressed.emit(level_path)

func SetTransitioning():
	transitioning = false
