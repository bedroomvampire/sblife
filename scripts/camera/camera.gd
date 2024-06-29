extends Camera3D

@onready var area = $PlayerArea3D
@onready var main_cursor = $Sprite3D
@onready var hit_cursor = $Sprite3D2
@export var walk_prompt : Control
var hit : Dictionary
var is_click : bool
var has_entered : bool

func _ready():
	main_cursor.set_as_top_level(true)
	hit_cursor.set_as_top_level(true)

func _process(_delta):
	var ray = get_world_3d().direct_space_state
	var origin = project_ray_origin(get_viewport().get_mouse_position())
	var query = PhysicsRayQueryParameters3D.create(origin, floor_point_from_mouse_position())
	hit = ray.intersect_ray(query)
	query.collide_with_areas = true
	if Input.is_action_just_pressed("left_click"):
		if hit && !is_click && !TestScript.has_entered:
			if !hit.collider is CharacterBody3D && !hit.collider.has_node("Object"):
				hit_cursor.global_position = hit.position
				asdfghjkl()
				#TestScript.pos = hit.position
			if hit.collider.has_node("Object") && hit.collider.has_method("_prompt"):
				hit.collider._prompt()
				print("bonjour")
		elif !TestScript.has_entered:
			qwertyuiop()
	
	if Input.is_action_just_pressed("ui_cancel"):
		if is_click:
			qwertyuiop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if hit:
		main_cursor.global_position = hit.position

func floor_point_from_mouse_position() -> Vector3:
	var screen_pos = get_viewport().get_mouse_position()
	var ray_origin = project_ray_origin(screen_pos)
	var ray_direction = project_ray_normal(screen_pos)
	
	var t = -ray_origin.y / ray_direction.y
	return ray_origin + ray_direction * t

func asdfghjkl():
	var mouse_pos = get_viewport().get_mouse_position()
	walk_prompt.position = mouse_pos
	walk_prompt.visible = true
	is_click = true

func _on_walk_herebutton_pressed():
	MivesMoveCommands.move_mive(TestScript.selected_num, hit_cursor.global_position)
	walk_prompt.visible = false
	is_click = false

func qwertyuiop():
	walk_prompt.visible = false
	is_click = false

func _on_walk_and_switch_pressed():
	MivesMoveCommands.move_mive(TestScript.selected_num, hit_cursor.global_position)
	TestScript.switch_mive_forward()
	walk_prompt.visible = false
	is_click = false
