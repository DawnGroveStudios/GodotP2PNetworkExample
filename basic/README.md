# Basic

## Player
The playe scene implements the `P2PCharacterBody2D` which will handle the sync between clients under the hood. All that is required is adding the follwing to ready function if other steps are being taken in ready

```gdscript
func _ready() -> void:
	super() #Sets up Network Object
```

## Useful functions to Override
```gdscript
# server_physics_process will only be called on servers or owner of the object
func server_physics_process(delta: float) -> void:

# server_process will only be called on servers or owner of the object
func server_process(delta: float):

# client_process will only be called on clients
func client_process(delta: float):
```

## Useful Vars
```gdscript
# The sync priority will determine how often the object will be synced across clients.
# High, Low are currently the only priorities supported
#
# P2PNetwork.periodic_interval_low = 1.0 # Default duration between syncs
# P2PNetwork.periodic_interval_high = 0.05 # Default 
#
#
# All Objects are set to high before they are first spawned on every peers instance before dropping back to it's default value

sync_priority = P2PNetwork.SYNC_PRIORITY.HIGH

```


## P2PNetwork.rpc_sync()
This function will sync any object across the network, However there are a few important things to consider when using the function.
- The Node should have the var `network_id` so it can determine what client it belongs to. If not it will default to the server client
- Setting the Node name with `NetworkNodeHelper.set_object_name(self)`. This will ensure that the name of the node is unique before trying to sync.
- Destroying the node when a player leaves by adding the following signals
```gdscript
P2PNetwork.disconnect.connect(destroy)
P2PLobby.player_left_lobby.connect(player_left)

func destroy():
	P2PNetwork.rpc_remove_node(self)

func player_left(id):
	if network_id == id:
		destroy()
```

```gdscript
P2PNetwork.rpc_sync(self)
```
