extends Node2D

var spawnPoints : Array[Vector2] = [Vector2(0,0)]

func _on_child_entered_tree(node: Node) -> void:
	if !multiplayer.is_server(): return
	node.position = spawnPoints[randi_range(0,spawnPoints.size()-1)]
