extends P2PCharacterBody2D

@export var speed = 400

# all public vars are synced across P2P objects automatily
var player_name: String = "Default"



func _ready() -> void:
	super() #Sets up Network Object
	$Name.text = P2PNetwork.network_data.get_current_peer().profile_name

	# will sync this object based of this float P2PNetwork.periodic_interval_high
	# default is P2PNetwork.SYNC_PRIORITY.LOW once the object is seen by every client
	sync_priority = P2PNetwork.SYNC_PRIORITY.HIGH



func server_physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	look_at(get_global_mouse_position())
# OR

func server_process(delta: float):
	#get_input()
	#move_and_slide()
	pass

func client_process(delta: float):
	pass

func _process(delta: float) -> void:
	super(delta)


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
