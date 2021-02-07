extends StaticBody2D


export (Array) var layer_set
onready var is_active = Globals.active_layer in layer_set

func _ready():
	Globals.connect("layer_change", self, "_on_layer_change")
	_on_layer_change(Globals.active_layer)
	modulate = Color.white
	
func _on_layer_change(layer):
	is_active = layer in layer_set or len(layer_set) == 0
	visible = is_active
	if (!visible):
		collision_mask = 0
		collision_layer = 0
	else:
		collision_mask = 1
		collision_layer = 2
	

