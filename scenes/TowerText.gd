extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("rounds_changed", Callable(self, "_on_rounds_changed"))
	self.text = str(Global.rounds)
func _on_rounds_changed(new_rounds):
	self.text = str(new_rounds)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
