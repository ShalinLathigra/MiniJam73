extends Node

enum {
	BLACK,
	PINK,
	RED,
	GREEN
}

func black():
	return [ Color("#ffffff"), Color("#bfbfbf"), Color("#808080"), Color("#404040"), Color("#000000")]
func pink():
	return [Color("#eeb4b3"), Color("#c179b9"), Color("#a42cd6"), Color("#502274"), Color("#2f242c")]
func red():
	return [Color("#83b692"), Color("#f9ada0"), Color("#f9627d"), Color("#c65b7c"), Color("#5b3758")]
func green():
	return [Color("#dce1de"), Color("#9cc5a1"), Color("#49a078"), Color("#216869"), Color("#1f2421")]

onready var COLORS = {
	BLACK : black(),
	PINK : pink(),
	RED : red(),
	GREEN : green()
}

var unlocked_layers = [BLACK]
#var unlocked_layers = [BLACK, PINK, RED, GREEN]

func add_lense(lense):
	unlocked_layers.push_back(lense)
	
var active_layer = BLACK
var index = 0

signal layer_change (args)

func advance_layer(delta):
	if (index == 0 and delta < 0):
		index = len(unlocked_layers)
	index = (index + delta) % len(unlocked_layers)
	active_layer = unlocked_layers[index]
	emit_signal("layer_change", active_layer)

var key_count = 3
var max_keys = 3
	
func add_key():
	key_count += 1
