extends Node
class_name Wand

@onready var spell_slots: Dictionary = {
	1: $FireballSpell,
	2: $EnergyBulletSpell,
	3: null,
	4: null,
	5: null
}

@onready var firepoint : Node2D = $Firepoint

func _unhandled_input(e: InputEvent) -> void:
	if !is_multiplayer_authority(): return
	if e.is_pressed():
		if Input.is_action_just_pressed("spell1"): _press(1)
		if Input.is_action_just_pressed("spell2"): _press(2)
		if Input.is_action_just_pressed("spell3"): _press(3)
		if Input.is_action_just_pressed("spell4"): _press(4)
		if Input.is_action_just_pressed("spell5"): _press(5)
	
	if e.is_released():
		if Input.is_action_just_released("spell1"): _release(1)
		if Input.is_action_just_released("spell2"): _release(2)
		if Input.is_action_just_released("spell3"): _release(3)
		if Input.is_action_just_released("spell4"): _release(4)
		if Input.is_action_just_released("spell5"): _release(5)
		
func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	_hold_if_down(1, "spell1", delta)
	_hold_if_down(2, "spell2", delta)
	_hold_if_down(3, "spell3", delta)
	_hold_if_down(4, "spell4", delta)
	_hold_if_down(5, "spell5", delta)

func _press(slot: int) -> void:
	if !is_multiplayer_authority(): return
	print("pressed")
	var s: Node = spell_slots[int(slot)]
	if s and s.has_method("on_pressed"):
		print("GUH")
		s.on_pressed(self)

func _release(slot: int) -> void:
	if !is_multiplayer_authority(): return
	print("released")
	var s: Node = spell_slots[int(slot)]
	if s and s.has_method("on_released"):
		print("HUH")
		s.on_released(self)

func _hold_if_down(slot: int, action: StringName, dt: float) -> void:
	if !is_multiplayer_authority(): return
	if Input.is_action_pressed(action):
		var s: Node = spell_slots[int(slot)]
		if s and s.has_method("on_hold"):
			s.on_hold(self, dt)
