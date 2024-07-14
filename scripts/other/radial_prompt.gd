# Code from https://forum.godotengine.org/t/how-to-a-radial-menu-pie-menu/26466/3
extends Container

#Creates a radial container node
@export var button_radius : float = 100 #in godot position units

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	place_buttons()

#Repositions the buttons
func place_buttons() -> void:
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

#utility function for adding buttons and recalculating their positions
#TODO: Should probably just use a signal to run place_button on any tree change
func add_button(btn) -> void:
	add_child(btn)
	place_buttons()
