extends Button

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed():
	if !P2PLobby.in_lobby():
		load_game()
	elif P2PNetwork.network_data.is_server():
		P2PNetwork.globalData.set_player_data("value",randi())
		if !P2PNetwork.network_data.do_all_peers_have_status(NetPeer.ConnectionStatus.READY):
			NetLog.warn("not all peers are ready")
			return

		if P2PNetwork.net_rpc(P2PNetwork.RPC_TYPE.ALL_CLIENTS,self,null,load_game):
			load_game()
			P2PNetwork.globalData.set_game_data("game_status","started")
	else:
		NetLog.warn("in lobby and not a server")

func load_game(network_id:int=-1):
	NetLog.info("loading game...")
	if (network_id == -1 || network_id == P2PLobby.get_id()):
		NetworkCommands.set_connection_state(NetPeer.ConnectionStatus.LOADING)
	# Destroy Main Menu Scene
	get_tree().get_root().get_node("/root/MainMenu").queue_free()
	# Create Game Scene
	var GameScene = load("res://Scenes/Game.tscn").instantiate()
	get_tree().root.add_child(GameScene)
	# This is used to only sync players that have the same scene active
	P2PNetwork.set_current_scene("game",GameScene)
	if (network_id == -1 || network_id == P2PLobby.get_id()):
		NetworkCommands.set_connection_state(NetPeer.ConnectionStatus.LOADED)
