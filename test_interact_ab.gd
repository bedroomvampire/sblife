extends Button

@onready var marker = $Marker3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact():
	MivesMoveCommands.move_mive_task(TestScript.selected_num, marker.global_position,"fill_test")

func interact_random():
	var random_num = randi_range(1,TestScript.mives_available)
	MivesMoveCommands.move_mive_task(random_num, marker.global_position,"fill_test")
