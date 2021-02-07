extends "res://Components/Interactable.gd"


signal activated

func _ready():
	var node = get_tree().get_root().get_node("/root/Main")
	$".".connect("activated", node, "_on_key_added")
	._ready()

func activate():
	emit_signal("activated")
	call_deferred("free")
