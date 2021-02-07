extends KinematicBody2D

export (float, 100, 300) var move_speed
export (float, 0, 1) var friction = 0.5
export (float) var gravity = 980
export (float) var jumpforce = 500

onready var vel = Vector2(0,0)
onready var grounded = false

onready var active = false

func process_horizontal_input():
	var dir : float = 0.0
	$Particles2D.process_material.gravity.x = 0.0
	if (Input.is_action_pressed("Left")):
		$Particles2D.process_material.gravity.x += 98
		dir -= 1
	if (Input.is_action_pressed("Right")):
		$Particles2D.process_material.gravity.x -= 98
		dir += 1
	return dir

func process_vertical_input():
	if (Input.is_action_just_pressed("Jump")):
		$JumpPlayer.play(0.0)
		vel.y = -jumpforce


func _physics_process(delta):
	if (active):
		vel.x = process_horizontal_input() * move_speed
		$AnimatedSprite.flip_h = vel.x < 0.0
		if (is_on_floor()):
			if (vel.x == 0.0):
				$Particles2D.emitting = false
				if (!changing):
					$AnimatedSprite.play("Idle")
			else:
				$Particles2D.emitting = true
				$AnimatedSprite.play("Move")
			vel.y = 0.0
			process_vertical_input()
		else:
			$Particles2D.emitting = false
			if (vel.y < 0.0):
				$AnimatedSprite.play("Jump")
			else: 
				$AnimatedSprite.play("Fall")
		vel.y += gravity * delta
		
		vel = move_and_slide(vel, Vector2.UP)
		vel = lerp(vel, Vector2(0,0), friction)
	else:
		if (Input.is_action_just_pressed("Interact")):
			active = true
			get_node("/root/Main").start_time()

# Item Handling here!
	
var near_item = null

var changing = false

func _unhandled_input(event):
	if (active):
		if Input.is_action_just_pressed("Interact"):
			$AnimatedSprite.play("Use")
			changing = true
			if (near_item):
				if (near_item.get("is_active") != null):
					if (near_item.is_active):
						near_item.activate()
		if (Input.is_action_just_pressed("FrontChange")):
			$AnimatedSprite.play("Use")
			changing = true
			Globals.advance_layer(1)
		if (Input.is_action_just_pressed("BackChange")):
			$AnimatedSprite.play("Use")
			changing = true
			Globals.advance_layer(-1)

func _on_AnimatedSprite_animation_finished():
	if (changing):
		changing = false
