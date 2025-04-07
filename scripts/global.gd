extends Node
signal rounds_changed(new_rounds)
var rounds = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_rounds(new_value):
	rounds = new_value
	emit_signal("rounds_changed", rounds)
