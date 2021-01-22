extends KinematicBody2D

const torch = preload("res://Torch.tscn")

const FRICTION = 1500
const MAX_SPEED = 100
const ACCELERATION = 900

var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("LMB"):
		place_torch()

func place_torch():
	var torch_instance = torch.instance()
	torch_instance.position = get_global_position()
	torch_instance.rotation_degrees = rotation_degrees
	get_tree().get_root().call_deferred("add_child",torch_instance)
