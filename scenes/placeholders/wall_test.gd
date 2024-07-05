extends Node3D

var hit : Dictionary
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
		var pos = snapped(hit.position, Vector3(1,1,1))
		var init_pos : Vector3
		#print(pos)
		if Input.is_action_pressed("left_click"):
			init_pos = pos
		if Input.is_action_just_released("left_click"):
			var final_pos = pos
			var final_result = snapped((init_pos - final_pos).normalized(), Vector3(1,1,1))
			print(final_result)
