extends Area2D


export (NodePath) var target

export (String) var input_flag

export (String, MULTILINE) var text
export (String, MULTILINE) var text2
export (String, MULTILINE) var text3
export (String, MULTILINE) var text4
export (int) var lines
onready var i = 1

var active = false
onready var word_rate = 500.0
onready var t = get_node(target)

var max_text_count = 5.0
var text_count = max_text_count

func _ready():
	if (t):
		t.text = text
		t.visible_characters = 0

func _process(delta):
	if (active and t):
		t.visible_characters += delta * word_rate
		
		if (t.visible_characters >= len(t.text)):
			text_count -= delta
			if (Input.is_action_pressed(input_flag) or text_count < 0):
				advance_text()
				text_count = max_text_count

func advance_text():
	if (i < lines):
		i += 1
		match i:
			2:
				t.text = text2
				t.visible_characters = 0
			3:
				t.text = text3
				t.visible_characters = 0
			4:
				t.text = text4
				t.visible_characters = 0


func _on_TextTrigger_body_entered(body):
	active = true
	if (i >= lines):
		collision_mask = 0


func _on_TextTrigger_body_exited(body):
	advance_text()
	active = false
