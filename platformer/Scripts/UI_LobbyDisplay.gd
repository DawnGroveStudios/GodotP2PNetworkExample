extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	P2PLobby.lobby_joined.connect(_joined_lobby)
	P2PLobby.lobby_created.connect(_joined_lobby)
	P2PLobby.player_left_lobby.connect(_left_lobby)
	P2PLobby.found_lobbies.connect(_on_match_list)

func _on_match_list(lobbies:Array[LobbyData]):
	if !P2PLobby.in_lobby():
		$P2P_LobbyList.visible = true


func _joined_lobby(id):
	$P2P_ChatText.show()
	$P2P_LobbyList.visible = false
	$LobbyData.show()
	$LobbyData.text = P2PLobby._current_lobby.string()

func _left_lobby(id):
	if id == P2PLobby.get_id():
		$P2P_ChatText.hide()
		$LobbyData.hide()
		$P2P_LobbyList.visible = true
		#$P2P_LobbyList.show()

