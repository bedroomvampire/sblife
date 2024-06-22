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

const SPEED = 5.0
const LERP_VAL = .125
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	playermive_num += TestScript.mives_available + 1
	TestScript.mives_available += 1
	MivesMoveCommands.miveMoveCommands.emit(moveSomewhere)
	destination = position

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()
	
	velocity = Vector3.ZERO
	agent.set_target_position(destination)
	var next_point = agent.get_next_path_position()
	velocity = (next_point - global_transform.origin).normalized() * SPEED
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), LERP_VAL)

func _process(_delta):
	if TestScript.selected_num == playermive_num:
		active = true
	else:
		active = false
	
	if active:
		indicator.visible = true
	else:
		indicator.visible = false
	
	_on_mive_go()


func _on_mive_go():
	if MivesMoveCommands.mive == playermive_num:
		destination = MivesMoveCommands.position
