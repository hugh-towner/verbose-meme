extends KinematicBody2D

var torch = preload("res://Torch.tscn")
var movespeed = 180

onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	var motion = Vector2()

	if Input.is_action_pressed("up"):
		animationPlayer.play("WalkUp")
		motion.y -= 1
	elif Input.is_action_pressed("down"):
		animationPlayer.play("WalkDown")
		motion.y += 1
	elif Input.is_action_pressed("right"):
		animationPlayer.play("WalkRight")
		motion.x += 1
	elif Input.is_action_pressed("left"):
		animationPlayer.play("WalkLeft")
		motion.x -= 1
	else:
		animationPlayer.play("IdleFront")
	
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	
	if Input.is_action_just_pressed("LMB"):
		place_torch()

func place_torch():
	var torch_instance = torch.instance()
	torch_instance.position = get_global_position()
	torch_instance.rotation_degrees = rotation_degrees
	get_tree().get_root().call_deferred("add_child",torch_instance)
