extends KinematicBody2D

var torch = preload("res://Torch.tscn")
var movespeed = 250

func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	var motion = Vector2()

	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("right"):
		motion.x += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1

	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	
	if Input.is_action_just_pressed("LMB"):
		place_torch()

func place_torch():
	var torch_instance = torch.instance()
	torch_instance.position = get_global_position()
	torch_instance.rotation_degrees = rotation_degrees
	get_tree().get_root().call_deferred("add_child",torch_instance)
