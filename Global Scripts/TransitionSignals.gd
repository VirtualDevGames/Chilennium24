extends Node

signal TransitionButtonPressed(level_path : String)
signal FadeToBlack
signal FadeToBlackFinished
signal FadeToClearFinished

signal LevelCleared

var came_from_level = false
var level_ended = false
