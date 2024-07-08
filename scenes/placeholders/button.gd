extends Button

@export var build_type_num : int

func _pressed():
	release_focus()
	TestScript.build_type_mode = build_type_num
	print(TestScript.build_type_mode)
