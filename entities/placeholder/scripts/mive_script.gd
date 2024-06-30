extends CharacterBody3D

signal moveSomewhere

@onready var agent = $NavigationAgent3D
@onready var indicator = $Indicator

var playermive_num : int
@export var first_name = "John"
@export var sur_name = "Doe"

var mive_name = first_name + " " + sur_name
var active : bool = true
var destination : Vector3
var reached : bool

const SPEED = 5.0
const LERP_VAL = .125
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	playermive_num += TestScript.mives_available + 1
	TestScript.mives_available += 1
	TestScript.mives_array.resize(TestScript.mives_available)
	TestScript.mives_array.fill(self)
	MivesMoveCommands.miveMoveCommands.emit(moveSomewhere)
	destination = position

func _physics_process(delta):
	reached = false
	
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y -= gravity * delta
	
	move_and_slide()
	
	var current_location = global_transform.origin
	var next_location = agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), LERP_VAL)
	
	velocity = new_velocity

func _process(_delta):
	if TestScript.selected_num == playermive_num:
		active = true
	else:
		active = false
	
	if active:
		indicator.visible = true
		TestScript.follow_position = global_position
	else:
		indicator.visible = false
	
	_on_mive_go()


func _on_mive_go():
	if MivesMoveCommands.mive == playermive_num:
		agent.target_position = MivesMoveCommands.position


func _target_reached():
	reached = true
