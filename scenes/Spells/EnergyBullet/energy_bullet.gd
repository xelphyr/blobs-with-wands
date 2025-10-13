extends Area2D

var velocity = Vector2(0,0)
var origin_player
var damage = 20

func _physics_process(delta: float) -> void:
	position += velocity*delta
	velocity += Vector2(0, 100*delta)
	rotation = velocity.angle()


func _on_body_entered(body: Node2D) -> void:
	var player = body.get_parent()
	if player and player != origin_player:
		set_deferred('monitoring', false)
		$CollisionShape2D.set_deferred('monitoring', false)
		_resolve_hit(body)

		
func _resolve_hit(body: Node2D) -> void:
	var player = body.get_parent()
	if not player or not player.is_inside_tree():
		queue_free()
	
	if player.has_method("damage"):
		player.call_deferred("damage", damage)
		
	queue_free()
