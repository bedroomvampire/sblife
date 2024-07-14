extends CharacterBody3D

@export var prompt : Control

var is_click : bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(_event : InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		if !TestScript.has_entered && is_click:
			qwertyuiop()
	
	if Input.is_action_just_pressed("ui_cancel"):
		if is_click:
			qwertyuiop()

func _prompt() -> void:
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	prompt.position = mouse_pos
	prompt.visible = true
	is_click = true

func qwertyuiop() -> void:
	prompt.visible = false
	is_click = false
