extends Node
class_name LevelSelectManager

var is_transitioning : bool = true
@export var checks : Array[Control]

func _ready():
	ConnectTransitionSignals()
	ShowChecks()
	
func ConnectTransitionSignals():
	TransitionSignals.TransitionButtonPressed.connect(TransitionToLevel)
	TransitionSignals.FadeToClearFinished.connect(EnableInput)

func TransitionToLevel(level_path : String):
	print("HELLOOOO FROM HERE")
	if !is_transitioning && (level_path != null) :
		is_transitioning = true
		TransitionSignals.FadeToBlack.emit()
		await TransitionSignals.FadeToBlackFinished
		get_tree().change_scene_to_file(level_path)

func EnableInput() :
	is_transitioning = false

func ShowChecks():
	for level_number in LevelsCompleted.levels_completed:
		checks[level_number-1].visible = true
