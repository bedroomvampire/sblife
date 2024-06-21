extends Node

var sims_available : int
var selected_num : int
var pos : Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	selected_num = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("switch_sim"):
		if selected_num >= sims_available:
			selected_num = 1
		else:
			selected_num += 1
