extends Node2D

@export var max_health : float
@export var max_mana : float
@export var health_regen : float
@export var mana_regen : float
@export var current_health : float
@export var current_mana : float

func _enter_tree() -> void:
	# Assign authority for the whole subtree BEFORE any _ready() runs
	var owner_id := name.to_int()
	if owner_id > 0:
		set_multiplayer_authority(owner_id, true)

func _ready() -> void:
	current_health = max_health
	current_mana = max_mana
	$Player/Health.max_value = max_health
	$Player/Health.value = current_health
	$Player/Mana.max_value = max_mana
	$Player/Mana.value = current_mana
	
	global_transform
	
	var cfg := SceneReplicationConfig.new()
	cfg.add_property(":global_position") 
	cfg.add_property(":max_health")
	cfg.add_property(":max_mana")
	cfg.add_property(":current_health")
	cfg.add_property(":current_mana")
	cfg.add_property(":mana_regen")
	cfg.add_property(":health_regen")
	for i in range(0,28):
		cfg.add_property("Softbody2D/Bone-%d:global_position" % i) 
	$MultiplayerSynchronizer.root_path = "."
	$MultiplayerSynchronizer.replication_config = cfg
	
	call_deferred("_late_ready")

func _late_ready() -> void:
	await get_tree().process_frame
	var mp := multiplayer
	if mp == null or mp.multiplayer_peer == null: return
	_set_softbody_simulation_enabled(get_multiplayer_authority() == mp.get_unique_id())

func _set_softbody_simulation_enabled(enabled: bool) -> void:
	# Example toggles—adapt to your softbody plugin
	for part in get_tree().get_nodes_in_group("softbody_parts"):
		if part is RigidBody2D:
			part.freeze = !enabled
			part.custom_integrator = !enabled
	
func _process(dt : float) -> void:
	current_health = min(current_health + health_regen*dt, max_health)
	current_mana = min(current_mana + mana_regen*dt, max_mana)
	$Player/Health.value = current_health
	$Player/Mana.value = current_mana
	
func get_health() -> float:
	if !is_multiplayer_authority(): return 0
	return current_health

func get_mana() -> float:
	if !is_multiplayer_authority(): return 0
	return current_mana

func mana_consume(amount: float) -> bool:
	if current_mana - amount < 0:
		return false
	else:
		current_mana -= amount
		$Player/Mana.value = current_mana
		return true 

func damage(amount: float) -> bool:
	print("owie")
	current_health = max(0,current_health-amount)
	$Player/Health.value = current_health
	if current_health == 0:
		queue_free()
	return true
	
		
