extends Button

@onready var marker : Marker3D = $Marker3D

func interact() -> void:
	MivesMoveCommands.move_mive_task(TestScript.selected_num, marker.global_position,"fill_test")

func interact_random() -> void:
	var random_num = randi_range(1,TestScript.mives_available)
	MivesMoveCommands.move_mive_task(random_num, marker.global_position,"fill_test")
