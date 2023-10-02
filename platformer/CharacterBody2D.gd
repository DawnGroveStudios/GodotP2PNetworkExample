extends P2PCharacterBody2D

@export var speed = 500

@export var max_jumps = 2
@export var jump_speed = 600
var _remaining_jumps = 0

var _gravity = 9.8
var _current_speed = 0

func _ready():
	super()
	_remaining_jumps = max_jumps
	$Name.text = P2PNetwork.network_data.get_current_peer().profile_name

func get_input() ->Vector2:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	input_direction.y = 0
	return input_direction * speed

func server_process(delta: float) -> void:
	var v  = get_input()
	velocity.x = v.x
	if Input.is_action_just_pressed("jump") and _remaining_jumps > 0:
		_remaining_jumps -= 1
		velocity += Vector2(0,-jump_speed)
	elif !is_on_floor():
		velocity += Vector2(0,_gravity)
	else:
		_remaining_jumps = max_jumps
	move_and_slide()

