extends Area2D

var aoe_can_dmg = true

func _process(delta: float) -> void:
	for body in get_overlapping_bodies():
		var player = body.get_parent()
		if player and player.is_in_group("Player") and player.has_method("damage") and aoe_can_dmg:
			player.call_deferred("damage", 5)
			aoe_can_dmg = false
			$DmgCooldown.start()
	
	$Ellipse.fill_color.a = ($Lifetime.time_left/$Lifetime.wait_time)*0.4
	$Ellipse.outline_color.a = ($Lifetime.time_left/$Lifetime.wait_time)
		

func _on_dmg_cooldown_timeout() -> void:
	aoe_can_dmg = true

func _on_lifetime_timeout() -> void:
	queue_free()
