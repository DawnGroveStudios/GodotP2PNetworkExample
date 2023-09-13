extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _button_pressed():
	if !P2PLobby.in_lobby():
		load_game()
	elif P2PNetwork.network_data.is_server():
		P2PNetwork.globalData.set_player_data("value",randi())
		if !P2PNetwork.network_data.do_all_peers_have_status(NetPeer.ConnectionStatus.READY):
			GodotLogger.warn("not all peers are ready")
			return
		if P2PNetwork.net_rpc(P2PNetwork.RPC_TYPE.ALL_CLIENTS,self,null,load_game):
			load_game()
	else:
		GodotLogger.warn("in lobby and not a server")

func load_game(network_id:int=-1):
	GodotLogger.info("loading game...")
	if (network_id == -1 || network_id == P2PLobby.get_id()):
		NetworkCommands.set_connection_state(NetPeer.ConnectionStatus.LOADING)

	get_tree().root.add_child(preload("res://Scene/game.tscn").instantiate())
	if (network_id == -1 || network_id == P2PLobby.get_id()):
		NetworkCommands.set_connection_state(NetPeer.ConnectionStatus.LOADED)
