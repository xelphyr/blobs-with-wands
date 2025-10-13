extends Control



func _on_client_pressed() -> void:
	NetworkManager.join("localhost")


func _on_server_pressed() -> void:
	NetworkManager.host()
