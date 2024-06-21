extends CharacterBody3D

signal moveSomewhere

@onready var agent = $NavigationAgent3D
@onready var plumbob = $Plummob

@export var playersim_num : int
@export var first_name = "John"
@export var sur_name = "Doe"

var sim_name = first_name + " " + sur_name
var active : bool = true
var destination : Vector3

const SPEED = 5.0
const LERP_VAL = .125
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	TestScript.sims_available += 1
	SimMoveCommands.simMoveCommands.emit(moveSomewhere)
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
	if TestScript.selected_num == playersim_num:
		active = true
	else:
		active = false
	
	if active:
		plumbob.visible = true
	else:
		plumbob.visible = false
	
	_on_sim_go()


func _on_sim_go():
	if SimMoveCommands.sim == playersim_num:
		destination = SimMoveCommands.position
