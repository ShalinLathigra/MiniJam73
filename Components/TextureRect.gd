extends TextureRect

var prev_colors = null
var curr_colors = null
onready var anim_time = 0.0
onready var to_black = 0.0
export var anim_speed = 3.0

func _ready():
	prev_colors = Globals.BLACK
	curr_colors = Globals.BLACK
	Globals.connect("layer_change", self, "_on_layer_change")
	update_colors()

func _process(delta):
	if (anim_time < 1.5):
		material.set_shader_param("color_switch", anim_time)
		anim_time += delta * anim_speed
	
	if (curr_colors == Globals.BLACK):	# IF going from colour to black, transition to 0
		to_black = max(to_black - delta * anim_speed, 0.0)
		material.set_shader_param("to_black", to_black)
	elif (prev_colors == Globals.BLACK):
		to_black = min(to_black + delta * anim_speed, 1.0)
		material.set_shader_param("to_black", to_black)
			
func update_colors():
	material.set_shader_param("c1", Globals.COLORS[prev_colors][0])
	material.set_shader_param("c2", Globals.COLORS[prev_colors][1])
	material.set_shader_param("c3", Globals.COLORS[prev_colors][2])
	material.set_shader_param("c4", Globals.COLORS[prev_colors][3])
	material.set_shader_param("c5", Globals.COLORS[prev_colors][4])
	
	material.set_shader_param("c6", Globals.COLORS[curr_colors][0])
	material.set_shader_param("c7", Globals.COLORS[curr_colors][1])
	material.set_shader_param("c8", Globals.COLORS[curr_colors][2])
	material.set_shader_param("c9", Globals.COLORS[curr_colors][3])
	material.set_shader_param("c0", Globals.COLORS[curr_colors][4])
func _on_layer_change(_layer):
	prev_colors = curr_colors
	curr_colors = Globals.active_layer
	anim_time = 0.0
	update_colors()
