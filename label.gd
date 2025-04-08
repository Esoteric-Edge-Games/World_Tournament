extends Label

signal action_triggered(action_name)
signal turn_passed

func _ready():
	self.text = "Choose an action: Meditate, Attack, Outwit"
	self.set_process_input(true)

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_M: 
				_emit_action("Meditate")
			KEY_A: 
				_emit_action("Attack")
			KEY_B: 
				_emit_action("Outwit")

func _emit_action(action_name: String):
	emit_signal("action_triggered", action_name)
	emit_signal("turn_passed")
	print("Acción ejecutada:", action_name)
