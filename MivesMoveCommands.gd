extends Node

signal miveMoveCommands

var mive : int
var position : Vector3
var given_task : String

func move_mive(miveID : int,pos : Vector3) -> void:
	mive = miveID
	position = pos
	given_task = ""

func move_mive_task(miveID : int,pos : Vector3,task : String) -> void:
	mive = miveID
	position = pos
	given_task = task
