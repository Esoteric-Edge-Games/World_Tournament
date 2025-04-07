extends Node
signal rounds_changed(new_rounds)
var rounds = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_rounds(new_value):
	rounds = new_value
	emit_signal("rounds_changed", rounds)

var player1 = {
	stats = {
		life = 900,
		mana = 600,
		damage_multiplier = 1,
		defense = 0,
		defense_percent = 0,
		crit_chance = 5,
		dodge = 0,
		rewind = 1,
	},
		effects = {
		damage_multiplier = {
			turns = -1,
			multiplier = 0,
		},
		healing = {
			turns = -1,
			healing = 0,
		},
		shield = {
			turns = NAN,
			shield = 0,
		},
		burn = {
			turns = -1,
			damage = 0
		},
		stun = {
			turns = -1
		},
	},
	actions = {
		basic_attack = {
			damage = 50
		},
		meditate = {
			recharge = 90
		},
		taunt = {
			dodge = {
				number = 40,
				turns = 1
			},
			defense = {
				number = -20,
				turns = 1
			}
		}
	},
	skills = {} #A rellenar con las skills
}

var player2 = {
	stats = {
		life = 900,
		mana = 600,
		damage_multiplier = 1,
		defense = 0,
		defense_percent = 0,
		crit_chance = 5,
		dodge = 0,
		rewind = 1,
	},
		effects = {
		damage_multiplier = {
			turns = -1,
			multiplier = 0,
		},
		healing = {
			turns = -1,
			healing = 0,
		},
		shield = {
			turns = NAN,
			shield = 0,
		},
		burn = {
			turns = -1,
			damage = 0
		},
		stun = {
			turns = -1
		},
	},
	actions = {
		basic_attack = {
			damage = 50
		},
		meditate = {
			recharge = 90
		},
		taunt = {
			dodge = {
				number = 40,
				turns = 1
			},
			defense = {
				number = -20,
				turns = 1
			}
		}
	},
	skills = {} #A rellenar con las skills
}
