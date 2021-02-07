extends Area2D

export (String) var anim
export (String) var input_flag
export (bool) var active = false

func _ready():
	if (active):
		$AnimatedSprite.play(anim)

func _process(delta):
	if (active):
		if (Input.is_action_pressed(input_flag)):
			call_deferred("free")
