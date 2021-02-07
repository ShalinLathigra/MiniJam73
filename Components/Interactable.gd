extends Area2D

onready var active = 0.0
export (Array) var layer_set
onready var is_active = Globals.active_layer in layer_set

func _ready():
	Globals.connect("layer_change", self, "_on_layer_change")
	_on_layer_change(Globals.active_layer)

func activate():
	call_deferred("free")

func _on_Interactable_area_entered(area):
	active = 1.0
	$Sprite.material.set_shader_param("active", active)
	$KeyboardIndicator.visible = true
	$KeyboardIndicator.play("F")
	
func _on_Interactable_area_exited(area):
	active = 0.0
	$Sprite.material.set_shader_param("active", active)
	$KeyboardIndicator.visible = false

func _on_layer_change(layer):
	is_active = layer in layer_set or len(layer_set) == 0
	visible = is_active
