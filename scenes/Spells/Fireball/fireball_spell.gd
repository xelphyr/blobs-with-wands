extends Node

@export var mana_cost : float = 20
var firepoint_ref: Node2D
const fireball_scene = preload("res://scenes/Spells/Fireball/Fireball.tscn")

func on_pressed(wand: Wand) -> void:
	firepoint_ref = wand.firepoint
	_on_fire_cooldown_timeout()
	$FireCooldown.start()

func on_released(wand: Wand) -> void:
	$FireCooldown.stop()

func _on_fire_cooldown_timeout() -> void:
	if $"../../..".mana_consume(mana_cost):
		var fireball = fireball_scene.instantiate()
		fireball.position = firepoint_ref.global_position
		var shoot_dir =  (firepoint_ref.get_global_mouse_position() - firepoint_ref.global_position).normalized()
		fireball.velocity = shoot_dir * 2000
		fireball.origin_player = $"../../.."
		get_tree().current_scene.add_child(fireball)
