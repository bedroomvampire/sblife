extends NavigationRegion3D

var hit : Dictionary
var posit_set : bool
var posit : Vector3
var obj_rot : Vector3
@export var camera : CharacterBody3D
@export var wall : Area3D
@export var object : Area3D
@onready var wall_cursor = $MeshInstance3D2

var wall_on : bool
var obj_on : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	bake_navigation_mesh()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var ray = get_world_3d().direct_space_state
	var origin = camera.camera.project_ray_origin(get_viewport().get_mouse_position())
	var query = PhysicsRayQueryParameters3D.create(origin, camera.camera.floor_point_from_mouse_position())
	hit = ray.intersect_ray(query)
	if hit:
		var init_pos : Vector3
		#print(pos)
		if wall_on:
			attach_wall(init_pos)
		elif obj_on:
			var pos = snapped(hit.position, Vector3(.5,.5,.5))
			object.position = pos
			
			if Input.is_action_just_pressed("left_click"):
				build_obj()
			
			if Input.is_action_just_pressed("<"):
				object.rotate_object_local(Vector3.UP, deg_to_rad(-45))
			elif Input.is_action_just_pressed(">"):
				object.rotate_object_local(Vector3.UP, deg_to_rad(45))

func _posit(A):
	posit = A

func attach_wall(init_pos):
	if Input.is_action_pressed("left_click"):
			wall_cursor.visible = true
			var pos = snapped(hit.position, Vector3(1,1,1))
			if !posit_set:
				init_pos = pos
				_posit(init_pos)
				print("A:")
				print(init_pos)
				posit_set = true
			var final_result = snapped((pos - posit), Vector3(1,1,1))
			wall_cursor.position = posit + (final_result / 2) + Vector3(0, 1, 0)
			wall_cursor.scale = (final_result * 4) + Vector3(1.5,1.0625,1.5)
	if Input.is_action_just_released("left_click"):
		wall_cursor.visible = false
		var pos = snapped(hit.position, Vector3(1,1,1))
		print("A:")
		print(posit)
		print("B:")
		var final_result = snapped((pos - posit), Vector3(1,1,1))
		print(final_result)
		wall.position = posit + (final_result / 2)
		wall.scale = (final_result * 4) + Vector3(1,1,1)
		#print("C:")
		#var wall_rot = Quaternion(pos, -posit)
		#print(wall_rot)
		posit_set = false
		build_wall()

func build_wall():
	wall = wall.duplicate()
	bake_navigation_mesh()
	add_child(wall)

func build_obj():
	obj_rot = object.rotation
	object = object.duplicate()
	bake_navigation_mesh()
	add_child(object)
	object.rotation = obj_rot
