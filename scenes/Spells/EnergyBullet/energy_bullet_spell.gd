extends Node

@export var mana_cost : float
var firepoint_ref: Node2D
const bullet_scene = preload("res://scenes/Spells/EnergyBullet/EnergyBullet.tscn")

func on_pressed(wand: Wand) -> void:
	print("Initiated!")
	firepoint_ref = wand.firepoint
	_on_fire_cooldown_timeout()
	$FireCooldown.start()

func on_released(wand: Wand) -> void:
	print("aww")
	$FireCooldown.stop()

func _on_fire_cooldown_timeout() -> void:
	if $"../../..".mana_consume(mana_cost):
		print("pew")
		var bullet = bullet_scene.instantiate()
		bullet.position = firepoint_ref.global_position
		var shoot_dir =  (firepoint_ref.get_global_mouse_position() - firepoint_ref.global_position).normalized()
		bullet.rotation = shoot_dir.angle()
		bullet.velocity = shoot_dir * 4000
		bullet.origin_player = $"../../.."
		get_tree().current_scene.add_child(bullet)
