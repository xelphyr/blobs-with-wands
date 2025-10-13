extends Node

const PORT: int = 42069

var peer: ENetMultiplayerPeer

signal server_start

func host(start_port := PORT, max_clients := 16) -> void:
	peer = ENetMultiplayerPeer.new()
	var ok := peer.create_server(start_port, max_clients)
	if ok != OK: 
		push_error("Failed to start server")
		return
	multiplayer.multiplayer_peer = peer
	print("Server listening on port %d" % start_port)
	emit_signal("server_start")

func join(host_ip := "localhost", host_port := PORT) -> void:
	print("Attempting Join...")
	peer = ENetMultiplayerPeer.new()
	var ok := peer.create_client(host_ip, host_port)
	if ok != OK: 
		push_error("Failed to connect") 
		return
	print("Created Client...")
	multiplayer.multiplayer_peer = peer
	print("Should be working?")

func stop() -> void:
	if multiplayer.multiplayer_peer:
		multiplayer.multiplayer_peer.close()
		multiplayer.multiplayer_peer = null



	
