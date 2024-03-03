extends CanvasLayer
class_name TransitionFade

@export var fade_to_clear : bool = true
@onready var animation_player = $AnimationPlayer
var transitioning = false
signal transition_finished

func _ready():
	TransitionSignals.FadeToBlack.connect(Transition)
	if fade_to_clear:
		animation_player.play("ToClear")

func Transition():
	if !transitioning:
		transitioning = true
		animation_player.play("ToBlack")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "ToBlack":
		TransitionSignals.FadeToBlackFinished.emit()
	if anim_name == "ToClear":
		TransitionSignals.FadeToClearFinished.emit()
