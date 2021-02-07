extends Area2D

export (String) var text
export (Vector2) var offset = Vector2(0,0)

export (NodePath) var pair
onready var is_active = true


func _ready():
	$Sprite/RichTextLabel.text = text
	$Sprite.position += offset
	
func activate():
	if (is_active):
		var node = get_tree().get_root().get_node("/root/Main/Robot")
		node.global_position = get_node(pair).global_position
		get_node(pair).is_active = true


func _on_Door_body_exited(body):
	if (body.name == "Robot"):
		body.near_item = self
		is_active = false
		$AnimatedSprite.material.set_shader_param("active", is_active)
		$KeyboardIndicator.visible = false
	

func _on_Door_body_entered(body):
	if (body.name == "Robot"):
		is_active = true
		$AnimatedSprite.material.set_shader_param("active", is_active)
		$KeyboardIndicator.visible = true
		$KeyboardIndicator.play("F")
