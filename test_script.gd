extends Node

var mives_available : int = 0
var selected_num : int
var pos : Vector3
var mives_array : Array[Node3D]
var follow_position : Vector3

var has_entered : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	selected_num = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("switch_mive"):
		switch_mive_forward()

func switch_mive_forward():
	if selected_num >= mives_available:
		selected_num = 1
	else:
		selected_num += 1
