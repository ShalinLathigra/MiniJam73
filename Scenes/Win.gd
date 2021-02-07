extends Node2D

export (String) var ButtonPath

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_MenuButton_pressed():
	get_tree().change_scene(ButtonPath)
