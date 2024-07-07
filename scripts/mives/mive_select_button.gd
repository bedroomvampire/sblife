extends Button

@export var mive_number : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func switch_mive():
	if mive_number:
		TestScript.switch_mive(mive_number)
		release_focus()
