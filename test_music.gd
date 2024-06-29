extends Button

@onready var music = $AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if music.playing:
		text = "Stop music"
	else:
		text = "Play music"

func _on_pressed():
	if music.playing:
		music.stop()
	else:
		music.play()
