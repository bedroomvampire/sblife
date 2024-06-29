extends Node

func _mouse_entered():
	TestScript.has_entered = true

func _mouse_exited():
	TestScript.has_entered = false
