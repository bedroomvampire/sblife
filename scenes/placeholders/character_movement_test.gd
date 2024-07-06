extends Node

@export var camera : Camera3D

func _physics_process(_delta):
	if Input.is_action_just_pressed("test_move"):
		camera._on_walk_herebutton_pressed()
