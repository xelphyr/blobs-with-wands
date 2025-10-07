extends Node
class_name Wand

enum Slot {Spell1, Spell2, Spell3, Spell4, Spell5}

@export var slots: Dictionary = {
	Slot.Spell1: null,
	Slot.Spell2: null,
	Slot.Spell3: null,
	Slot.Spell4: null,
	Slot.Spell5: null
}

func _unhandled_input(e: InputEvent) -> void:
	if e.is_pressed():
		if Input.is_action_just_pressed("spell1"): _press(Slot.Spell1)
		if Input.is_action_just_pressed("spell2"): _press(Slot.Spell2)
		if Input.is_action_just_pressed("spell3"): _press(Slot.Spell3)
		if Input.is_action_just_pressed("spell4"): _press(Slot.Spell4)
		if Input.is_action_just_pressed("spell5"): _press(Slot.Spell5)
	
	if e.is_released():
		if Input.is_action_just_released("spell1"): _release(Slot.Spell1)
		if Input.is_action_just_released("spell2"): _release(Slot.Spell2)
		if Input.is_action_just_released("spell3"): _release(Slot.Spell3)
		if Input.is_action_just_released("spell4"): _release(Slot.Spell4)
		if Input.is_action_just_released("spell5"): _release(Slot.Spell5)
		
func _physics_process(delta: float) -> void:
	_hold_if_down(Slot.Spell1, "spell1", delta)
	_hold_if_down(Slot.Spell2, "spell2", delta)
	_hold_if_down(Slot.Spell3, "spell3", delta)
	_hold_if_down(Slot.Spell4, "spell4", delta)
	_hold_if_down(Slot.Spell5, "spell5", delta)

func _press(slot: Slot) -> void:
	var s: Node = slots[slot]
	if s and s.has_method("on_pressed"):
		s.on_pressed(self)

func _release(slot: Slot) -> void:
	var s: Node = slots[slot]
	if s and s.has_method("on_released"):
		s.on_released(self)

func _hold_if_down(slot: Slot, action: StringName, dt: float) -> void:
	if Input.is_action_pressed(action):
		var s: Node = slots[slot]
		if s and s.has_method("on_hold"):
			s.on_hold(self, dt)
