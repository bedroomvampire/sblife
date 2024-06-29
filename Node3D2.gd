extends CharacterBody3D

@onready var marker = $Node3D/Marker3D
@onready var spring = $Node3D/Marker3D/SpringArm3D
@onready var camera = $Node3D/Marker3D/SpringArm3D/Camera3D
@onready var node = $Node3D
@onready var raycast = $RayCast3D

const normal_speed = 9.375
const shift_speed = 25.0

var SPEED = 20.0
var following : bool = false
var cam_sensitivity : float = 0.0035
var mouse_pos : Vector2

var min_zoom : float = 4.5
var max_zoom : float = 60
var zoom_factor : float = 2
var zoom_duration : float = 5

@export var cam_rot : Vector2 = Vector2(37.5,0)
@export var _zoom_level : float = 20

func _ready():
	#spring.rotation.x = cam_rot.x
	#marker.rotation.y = cam_rot.y
	spring.spring_length = _zoom_level

func _unhandled_input(event):
	handle_camera_rotation(event)
	handle_scroll_zoom(event)
	if Input.is_action_just_pressed("follow_test"):
		if following:
			following = false
		else:
			following = true

func handle_camera_rotation(event):
	if event is InputEventMouseMotion && Input.is_action_pressed("camera_rotate"):
		if !Input.is_action_pressed("camera_move"):
			marker.global_rotation.y += -event.relative.x * cam_sensitivity
			spring.global_rotation.x += -event.relative.y * cam_sensitivity
	if event is InputEventMouseMotion && Input.is_action_pressed("camera_move"):
		mouse_pos.y += event.relative.x
		mouse_pos.x += event.relative.y
	else:
		mouse_pos.y = 0
		mouse_pos.x = 0

func handle_scroll_zoom(event):
	if event.is_action_pressed("zoom_up"):
		_zoom_level -= zoom_factor
	if event.is_action_pressed("zoom_down"):
		_zoom_level += zoom_factor

func _process(delta):
	handle_camera_zoom(delta)
	if Input.is_action_pressed("camera_rotate"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		#Input.warp_mouse(mouse_pos)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#mouse_pos = get_viewport().get_mouse_position()
	
	if Input.is_action_pressed("shift") && !following:
		SPEED = shift_speed
	else:
		SPEED = normal_speed

func handle_camera_zoom(delta):
	if Input.is_action_pressed("zoom_up"):
		_zoom_level -= zoom_factor * delta * 30
	if Input.is_action_pressed("zoom_down"):
		_zoom_level += zoom_factor * delta * 30

func _physics_process(delta):
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var key_dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	key_dir = key_dir.rotated(Vector3.UP, marker.rotation.y)
	
	var mouse_dir = (transform.basis * Vector3(mouse_pos.x, mouse_pos.y, 0)).normalized()
	mouse_dir = mouse_dir.rotated(Vector3.UP, marker.rotation.y)
	
	if following:
		global_position.x = lerp(global_position.x, TestScript.follow_position.x, delta * 4)
		global_position.z = lerp(global_position.z, TestScript.follow_position.z, delta * 4)
	else:
		if key_dir:
			velocity.x = lerp(velocity.x, key_dir.x * SPEED, delta * 8)
			velocity.z = lerp(velocity.z, key_dir.z * SPEED, delta * 8)
		elif mouse_dir:
			velocity.x = lerp(velocity.x, mouse_dir.y * SPEED, delta * 8)
			velocity.z = lerp(velocity.z, mouse_dir.x * SPEED, delta * 8)
		else:
			velocity.x = lerp(velocity.x, 0.0, SPEED / 3 * delta)
			velocity.z = lerp(velocity.z, 0.0, SPEED / 3 * delta)
	
	move_and_slide()
	
	position.y = lerp(position.y, raycast.get_collision_point().y, delta * 8)
	spring.rotation.x = clamp(spring.rotation.x, deg_to_rad(-80), deg_to_rad(0))
	_zoom_level = clamp(_zoom_level, min_zoom, max_zoom)
	spring.spring_length = lerp(spring.spring_length, _zoom_level, zoom_duration * delta)
