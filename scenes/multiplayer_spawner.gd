extends MultiplayerSpawner

@export var network_player: PackedScene

var players : Dictionary = {}

func _ready() -> void:
	NetworkManager.connect("server_start", connect_to_server)
	
func connect_to_server() -> void:
	multiplayer.peer_connected.connect(spawn_player)
	multiplayer.peer_disconnected.connect(despawn_player)
	
func spawn_player(id: int) -> void:
	print("check")
	if !multiplayer.is_server(): return
	print("Attempting Spawn Player...")
	
	var player: Node = network_player.instantiate()
	player.name = str(id)
	player.set_multiplayer_authority(id)
	
	get_node(spawn_path).call_deferred("add_child", player)
	players[id] = player
	
func despawn_player(id: int) -> void:
	if !multiplayer.is_server(): return
	players[id].queue_free()
	
