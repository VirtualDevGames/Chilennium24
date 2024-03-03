extends Node

var levels_completed : Array[int]
var came_from_level = false

func CompleteLevel(l : int):
	if !levels_completed.has(l):
		levels_completed.append(l)

