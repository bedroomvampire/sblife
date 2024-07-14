extends Button

@export var mive_number : int

func switch_mive():
	if mive_number:
		TestScript.switch_mive(mive_number)
		release_focus()
