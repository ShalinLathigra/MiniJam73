extends "res://Components/Interactable.gd"

signal pulled

func _ready():
	._ready()

func activate():
	if (Globals.key_count == Globals.max_keys):
		emit_signal("pulled")
	else:
		print("Need %s more keys!" % (Globals.max_keys - Globals.key_count))
