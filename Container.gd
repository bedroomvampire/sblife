extends Container

@export var button_radius = 100 #in godot position units

func _ready():
	place_buttons()

#Repositions the buttons
func place_buttons():
	var buttons = get_children()
	
	#Stop before we cause problems when no buttons are available
	if buttons.size() == 0:
		return
	
	#Amount to change the angle for each button
	var angle_offset = (2*PI)/buttons.size() #in degrees
	
	var angle = 0 #in radians
	for btn in buttons:
		btn.grow_horizontal = Control.GROW_DIRECTION_END
		btn.position = Vector2(button_radius, 0).rotated(angle)
		if angle == PI*1.5 or angle == PI*0.5 or angle == PI*-0.5:
			btn.position.x -= btn.size.x / 2
		elif angle > PI*0.5 and angle < PI*1.5:
			btn.position.x -= btn.size.x
		angle += angle_offset
