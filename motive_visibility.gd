extends ColorRect

@onready var slider : Slider = $HSlider

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	slider.value = TestScript.motive_visible
