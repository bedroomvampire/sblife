extends Node3D

var hit : Dictionary
var posit_set : bool
var posit : Vector3
@export var camera : CharacterBody3D
@onready var wall_test = $MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var ray = get_world_3d().direct_space_state
	var origin = camera.camera.project_ray_origin(get_viewport().get_mouse_position())
	var query = PhysicsRayQueryParameters3D.create(origin, camera.camera.floor_point_from_mouse_position())
	hit = ray.intersect_ray(query)
	if hit:
		var init_pos : Vector3
		#print(pos)
		if Input.is_action_pressed("left_click"):
			var pos = snapped(hit.position, Vector3(1,1,1))
			if !posit_set:
				init_pos = pos
				_posit(init_pos)
				print("A:")
				print(init_pos)
				posit_set = true
		if Input.is_action_just_released("left_click"):
			var pos = snapped(hit.position, Vector3(1,1,1))
			print("A:")
			print(posit)
			print("B:")
			var final_result = snapped((pos - posit), Vector3(1,1,1))
			print(final_result)
			wall_test.position = posit + (final_result / 2) + Vector3(0, 1.5, 0)
			wall_test.scale = (final_result * 4) + Vector3(1,1,1)
			#print("C:")
			#var wall_rot = Quaternion(pos, -posit)
			#print(wall_rot)
			posit_set = false

func _posit(A):
	posit = A
