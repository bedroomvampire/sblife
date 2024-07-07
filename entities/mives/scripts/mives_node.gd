extends Node

@export_range(0, 100) var test_motive : float = 82.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if test_motive >= 0.00:
		if test_motive >= 50.0:
			test_motive -= 0.1 * delta
		else:
			test_motive -= 0.05 * delta
