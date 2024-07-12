extends Node

var is_click : bool
@export var prompt : Node
@onready var talk_pos : Marker3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _prompt():
	var mouse_pos = get_viewport().get_mouse_position()
	prompt.position = mouse_pos
	prompt.visible = true
	is_click = true

func qwertyuiop():
	prompt.visible = false
	is_click = false

func friendly_talk_test():
	MivesMoveCommands.move_mive_task(TestScript.selected_num, talk_pos.global_position,"friendly_talk")

func mean_talk_test():
	MivesMoveCommands.move_mive_task(TestScript.selected_num, talk_pos.global_position,"mean_talk")
