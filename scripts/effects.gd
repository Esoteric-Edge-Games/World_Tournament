extends Node2D
	
#param0 name (string) 
#param1 target (player! / 2)
#param2 turns 
#param3 Numero de efecto (monto)

func process_effect(effect_name, target, turn, NoE, secondary_target, percent_life_steal) -> void: #Number of efect
	match effect_name:
			#En todos los parametros se recibe target dado que afecta a alguien (tanto al jugador como a la maquina)
		"damage":
			apply_damage(target,NoE) #Se reciben damage 
		"healing":
			apply_healing(target, NoE) #Se recibe heal 
		"shielding":
			apply_shield(target, NoE) #se recibe shield 
		"burn":
			apply_burn(target, NoE, turn) #Se recibe damage y turn
		"stun":
			apply_stun(target, NoE) #Se recibe turn
		"silence":
			apply_silence(target, turn) #Se recibe turn
		"robo_de_vida":
			apply_life_steal(target, NoE, secondary_target, percent_life_steal) #Se recibe damage, percent y life_steal
		"divine_favor":
			apply_divine_favor(target) #No se recibe ninguna variable ma que target
		"neutralised":
			apply_neutralized(target)  #Se recibe unicamente target (mismo caso anterior)
		"reflected":
			apply_reflection(target, NoE) #Se recibe percent
		"Desestabilizar":
			apply_destabilisation(target, NoE) #Se recibe reduction
		"rage":
			apply_rage(target, NoE) #Se recibe damage_increase y defense_reduction
		"fast_wait":
			apply_rewind(target, turn) #Se recibe turns
		"charm":
			apply_charmed(target,turn) #Se recibe target
		"wound":
			apply_wounds(target, turn) #Se recibe target
		"absorption":
			apply_absorption(target, NoE) #Se recibe percent
		"stasis":
			apply_stasis(target, turn) #Se recibe turns
		"sealed":
			apply_sealed(target, turn) #Se recibe turns
		"speed":
			apply_speed(target, turn, NoE) #Se recibe turns y speed
		"charge":
			apply_charge(target, NoE) #Se recibe percent
		"mana_charm":
			apply_mana_charm(target, turn)  #Se recibe percent
		"mana_barrier":
			apply_mana_barrier(target, NoE) #Se recibe percent 

# Daño "plano"
func apply_damage(target, damage) -> void:
	target.take_damage(damage)

# healing 
func apply_healing(target, heal_amount) -> void:
		target.heal(heal_amount)

# Shielding
func apply_shield(target, shield_amount) -> void:
		target.add_shield(shield_amount)

# Burn
func apply_burn(target, burn_damage, turns) -> void:
		target.add_effect("burn", {"damage": burn_damage, "turns": turns}) #crearle una sub-categoria

# stun
func apply_stun(target, turns) -> void:
		target.add_effect("stunned", {"turns": turns}) #crearle una sub-categoria

# Silence lowie
func apply_silence(target, turns) -> void:
		target.add_effect("silenced", {"turns": turns}) #crearle una sub-categoria

# Life Steal
func apply_life_steal(caster, NoE, victim, percent) -> void:
	apply_damage(victim, NoE)
	var healed = NoE * percent #TODO: Add victim resistance
	apply_healing(caster, percent)

# Divine Favor (o favior?)
func apply_divine_favor(target) -> void:
		target.remove_negative_effects()

# Neutralize
func apply_neutralized(target) -> void:
		target.remove_positive_effects()

# Reflect
func apply_reflection(target, reflect_percent) -> void:
		target.add_effect("reflect", {"percent": reflect_percent})

# Desestabilizar (odio el ingles)
func apply_destabilisation(target, dodge_reduction) -> void:
		target.reduce_dodge_chance(dodge_reduction)

# Rage (Totoro)
func apply_rage(target,NoE ) -> void:
		target.add_effect("rage", {"damage_increase": NoE, "defense_reduction": NoE})

# Espera Rapida (sugiero cambiarlo por Fast Turn o algo algo asi dado que no existe el termino "Esperar Rapido")
func apply_rewind(target, turns) -> void:
		target.add_effect("espera_rapida", {"turns": turns})

# Encantado de conocerlo
func apply_charmed(target, turns) -> void:
		target.add_effect("charmed", {"turns": turns})

# Heridas Graves (no quieren poner corta curas tambien? fanaticos del lol)
func apply_wounds(target, turns) -> void:
		target.add_effect("wounds", {"turns": turns})

# Función para absorción
func apply_absorption(target, absorb_percent) -> void:
		target.add_effect("absorption", {"percent": absorb_percent})

# Estasis
func apply_stasis(target, turns) -> void:
		target.add_effect("stasis", {"turns": turns}) #crearle una sub-categoria

# Sello
func apply_sealed(target, turns) -> void:
		target.add_effect("sealed", {"turns": turns})

# Velocidad relacionada a la chance de esquive
func apply_speed(target, speed_increase, turns) -> void:
		target.add_effect("speed", {"percent": speed_increase,"turns": turns})

# Cargado = +Chance critica (NO daño critico, chance)
func apply_charge(target, crit_increase) -> void:
		target.add_effect("charged", {"percent": crit_increase})

# Encantado de conocerlo (esta vez con maná)
func apply_mana_charm(target, percent) -> void:
		target.add_effect("mana_charm", {"percent": percent})

# Bari Bari no mi 
func apply_mana_barrier(target, damage ) -> void:
		target.add_effect("mana_barrier",)
		target.take_damage("damage") #no se si lo hice bien, pero quiero que el daño descuente mana en lugar de vida xd
