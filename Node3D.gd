extends Node3D

@onready var camera = %PlayerPhantomCamera3D
@onready var player = %PlayerCharacterBody3D

var cam_sensitivity : float = 0.0035
var mouse_pos

func _unhandled_input(event):
	handle_camera_rotation(event)

func handle_camera_rotation(event):
	if event is InputEventMouseMotion && Input.is_action_pressed("camera_rotate"):
		if !Input.is_action_pressed("camera_move"):
			camera.global_rotation.y += -event.relative.x * cam_sensitivity
			camera.global_rotation.x += -event.relative.y * cam_sensitivity
	if event is InputEventMouseMotion && Input.is_action_pressed("camera_move"):
		player.global_position.z += -event.relative.x * cam_sensitivity
		player.global_position.x += -event.relative.y * cam_sensitivity

func _process(delta):
	if Input.is_action_pressed("camera_rotate"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		#Input.warp_mouse(mouse_pos)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#mouse_pos = get_viewport().get_mouse_position()
