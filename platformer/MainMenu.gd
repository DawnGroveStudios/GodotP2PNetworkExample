extends Control



func _ready():
	P2PNetwork.globalData.game_data_updated.connect(_game_data_updated)
	P2PLobby.player_left_lobby.connect(_player_left_lobby)


func _game_data_updated(key:String):
	var data = P2PNetwork.globalData.get_game_data(key)
	match key:
		"game_status":
			if data == "started":
				hide()
			else:
				show()

func _player_left_lobby(network_id:int):
	if network_id == P2PNetwork.network_data.get_network_id():
		show()

func _show(visible:bool):
	if visible:
		hide()
	else:
		show()
