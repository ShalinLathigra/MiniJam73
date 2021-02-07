extends Node2D

export (NodePath) var timerDisplay

onready var timerString = "Shield Integrity: %s"
export (float) var max_time = 1200.0

var active = false
func _ready():
	get_node(timerDisplay).text = ""
	
func start_time():
	active = true
	$Timer.wait_time = max_time
	$Timer.start()
	
func _on_key_added():
	Globals.add_key()

func _on_lense_added(i):
	Globals.add_lense(i)
	$CoinPlayer.play(0.0)

func _process(_delta):
	if (active):
		get_node(timerDisplay).text = timerString % [int(($Timer.time_left / max_time) * 100.0)]


func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/Lose.tscn")
