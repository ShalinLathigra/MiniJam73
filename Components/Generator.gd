extends "res://Components/Interactable.gd"

signal pulled

func _ready():
	var node = get_tree().get_root().get_node("/root/Main")
	$".".connect("pulled", node, "_on_lever_pulled")
	._ready()

func activate():
	if (Globals.key_count == Globals.max_keys):
		emit_signal("pulled")
		$B1.play("Dark")
		$B2.play("Light")
		$B3.play("Mid")
		$Lever.play("Lever")


func _on_Lever_animation_finished():
	get_tree().change_scene("res://Scenes/Win.tscn")
