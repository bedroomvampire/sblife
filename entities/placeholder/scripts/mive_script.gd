extends CharacterBody3D

signal moveSomewhere

@onready var agent : NavigationAgent3D = $NavigationAgent3D
@onready var indicator : Node = $Indicator
@onready var mives : Node = $Mives

var playermive_num : int
@export var first_name := "John"
@export var sur_name := "Doe"

var mive_name : String = first_name + " " + sur_name
var active : bool = true
var destination : Vector3
var reached : bool
var done : bool

const SPEED = 5.0
const LERP_VAL = .125
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	playermive_num += TestScript.mives_available + 1
	TestScript.mives_available += 1
	TestScript.mives_array.resize(TestScript.mives_available)
	TestScript.mives_array.fill(self)
	MivesMoveCommands.miveMoveCommands.emit(moveSomewhere)
	destination = position

func _physics_process(delta : float) -> void:
	reached = false
	
	move_and_slide()
	
	var current_location : Vector3 = global_transform.origin
	var next_location : Vector3 = agent.get_next_path_position()
	var new_velocity : Vector3 = (next_location - current_location).normalized() * (delta * 100) * SPEED
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), LERP_VAL)
	
	velocity = new_velocity

func _process(_delta : float) -> void:
	if TestScript.selected_num == playermive_num:
		active = true
		TestScript.motive_visible = mives.test_motive
	else:
		active = false
	
	if active:
		indicator.visible = true
		TestScript.follow_position = global_position
	else:
		indicator.visible = false
	
	_on_mive_go()

func _on_mive_go() -> void:
	if MivesMoveCommands.mive == playermive_num:
		agent.target_position = MivesMoveCommands.position
		done = false

func _target_reached():
	reached = true
	if MivesMoveCommands.given_task && !done:
		done = true
		if MivesMoveCommands.given_task == "fill_test":
			mives.test_motive = 100
