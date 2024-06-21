extends Node

signal simMoveCommands

var sim
var position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move_sim(simID,pos):
	sim = simID
	position = pos
