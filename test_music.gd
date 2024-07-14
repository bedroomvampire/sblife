extends Button

@onready var music : AudioStreamPlayer3D = $AudioStreamPlayer3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	if music.playing:
		text = "Stop music"
	else:
		text = "Play music"

func _on_pressed():
	if music.playing:
		music.stop()
	else:
		music.play()
