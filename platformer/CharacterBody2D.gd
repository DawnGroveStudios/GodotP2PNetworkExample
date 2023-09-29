extends P2PRigidBody2D

@export var speed = 50

@export var max_jumps = 100
var _remaining_jumps = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#set_mode()
	_remaining_jumps = max_jumps
	NetLog.info("status",{"freeze":freeze})
	body_entered.connect(_body_entered)
	body_shape_entered.connect(_body_shape_entered)

	pass # Replace with function body.

func _body_entered(body):
	NetLog.info("entered body")
	_remaining_jumps = max_jumps

func _body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int):
	NetLog.info("entered body")

func get_input() ->Vector2:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	input_direction.y = 0
	return input_direction * speed

func server_process(delta: float) -> void:
	var v  = get_input()
	apply_central_impulse(v)

	if Input.is_action_just_pressed("jump") and _remaining_jumps > 0:
		_remaining_jumps -= 1
		NetLog.info("JUMP")
		apply_central_impulse(Vector2(0,-500))

	#look_at(get_global_mouse_position())
# Called every frame. 'delta' is the elapsed time since the previous frame.

