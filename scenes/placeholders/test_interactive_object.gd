extends CharacterBody3D

@export var prompt : VBoxContainer

var is_click : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		if !TestScript.has_entered:
			#qwertyuiop()
			pass
	
	if Input.is_action_just_pressed("ui_cancel"):
		if is_click:
			qwertyuiop()

func _prompt():
	var mouse_pos = get_viewport().get_mouse_position()
	prompt.position = mouse_pos
	prompt.visible = true
	is_click = true

func qwertyuiop():
	prompt.visible = false
	is_click = false
