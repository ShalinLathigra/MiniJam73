extends "res://Components/Interactable.gd"


export (int) var lens

signal activated (i)

func _ready():
	var node = get_tree().get_root().get_node("/root/Main")
	$".".connect("activated", node, "_on_lense_added")
	
	
func activate():
	emit_signal("activated", lens)
	.activate()
