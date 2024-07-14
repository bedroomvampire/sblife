extends NavigationRegion3D

var hit : Dictionary
var posit_set : bool
var posit : Vector3
var obj_rot : Vector3
@export var camera : CharacterBody3D
@export var wall : Area3D
@export var object : Area3D
@export var wall_cursor : Node3D
@onready var wall_indicator : Node = $MeshInstance3D2

var wall_on : bool
var obj_on : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bake_navigation_mesh(true)
	add_child(wall)
	wall = wall.duplicate()

func _input(_event : InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		TestScript.build_type_mode = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	var ray = get_world_3d().direct_space_state
	var origin = camera.camera.project_ray_origin(get_viewport().get_mouse_position())
	var query = PhysicsRayQueryParameters3D.create(origin, camera.camera.floor_point_from_mouse_position())
	hit = ray.intersect_ray(query)
	if hit:
		var init_pos : Vector3
		#print(pos)
		if TestScript.build_type_mode == 1 && !TestScript.has_entered:
			var pos : Vector3 = snapped(hit.position, Vector3(1,1,1))
			wall_cursor.visible = true
			object.visible = false
			wall_cursor.position = lerp(wall_cursor.position, pos, delta * 16)
			attach_wall(init_pos)
		elif TestScript.build_type_mode == 2 && !TestScript.has_entered:
			var pos : Vector3 = snapped(hit.position, Vector3(.5,.5,.5))
			wall_cursor.visible = false
			object.visible = true
			object.position = lerp(object.position, pos, delta * 16)
			attach_obj(init_pos)
		else:
			wall_cursor.visible = false
			object.visible = false

func _posit(A : Vector3) -> void:
	posit = A

func attach_wall(init_pos) -> void:
	if Input.is_action_pressed("left_click"):
			wall_indicator.visible = true
			var pos = snapped(hit.position, Vector3(1,1,1))
			if !posit_set:
				init_pos = pos
				_posit(init_pos)
				print("A:")
				print(init_pos)
				posit_set = true
			var final_result = snapped((pos - posit), Vector3(1,1,1))
			wall_indicator.position = posit + (final_result / 2) + Vector3(0, 1, 0)
			if final_result.x <= 0:
				wall_indicator.scale = (final_result * 4) + Vector3(-1.5,1.0625,1.5)
			elif final_result.z <= 0:
				wall_indicator.scale = (final_result * 4) + Vector3(1.5,1.0625,-1.5)
			elif final_result.x <= 0 && final_result.z <= 0:
				wall_indicator.scale = (final_result * 4) + Vector3(-1.5,1.0625,-1.5)
			else:
				wall_indicator.scale = (final_result * 4) + Vector3(1.5,1.0625,1.5)
	if Input.is_action_just_released("left_click"):
		wall_indicator.visible = false
		var pos = snapped(hit.position, Vector3(1,1,1))
		print("A:")
		print(posit)
		print("B:")
		var final_result = snapped((pos - posit), Vector3(1,1,1))
		print(final_result)
		wall.position = posit + (final_result / 2)
		if final_result.x <= 0:
			wall.scale = (final_result * 4) + Vector3(-1,1,1)
		elif final_result.z <= 0:
			wall.scale = (final_result * 4) + Vector3(1,1,-1)
		elif final_result.x <= 0 && final_result.z <= 0:
			wall.scale = (final_result * 4) + Vector3(-1,1,-1)
		else:
			wall.scale = (final_result * 4) + Vector3(1,1,1)
		#print("C:")
		#var wall_rot = Quaternion(pos, -posit)
		#print(wall_rot)
		posit_set = false
		build_wall()

func attach_obj(init_pos):
	if Input.is_action_just_pressed("left_click"):
			build_obj()
	if Input.is_action_just_pressed("<"):
		object.rotate_object_local(Vector3.UP, deg_to_rad(-45))
	elif Input.is_action_just_pressed(">"):
		object.rotate_object_local(Vector3.UP, deg_to_rad(45))

func build_wall() -> void:
	wall = wall.duplicate()
	add_child(wall)
	bake_navigation_mesh(true)

func remove_wall(obj) -> void:
	wall = wall.duplicate()
	obj.queue_free()
	bake_navigation_mesh(true)

func build_obj() -> void:
	obj_rot = object.rotation
	object = object.duplicate()
	add_child(object)
	object.rotation = obj_rot
	#bake_navigation_mesh(true)
