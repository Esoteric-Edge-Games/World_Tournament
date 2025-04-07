extends Node2D
<<<<<<< HEAD

var effects = {
	"damage": 0, # FLOAT Despues se cambia el valor a una variable que lo modique correctamente
	"mana":0, #FLOAT
	"shield": 0, #FLOAT
	"heal": 0, #FLOAT
	"turns": 0, #INT Luego cambiar a cantidad de turnos totales y "temporales" para los efectos como quemadura
	"burn": 0, # INT En una etapa mas avanzada se consideraran como ticks. ¿Servira crear una nueva variable?
	"stunned": 0, #INT Relacionar con turnos
	"life_steal": 0,# INT
	"percent": 0, #FLOAT
	"Silenced": 0, #INT Silencio clase baja. (Soy clase baja, legalmente puedo joder con esto(?)
	"reflected": 0, #FLOAT
	"rage": 0, # INT relacionar con turnos
	"damage_reduction": 0, #FLOAT
	"damage_increase":0, #Se puede manejar tanto INT como FLOAT en lo personal
	"quick_wait":0, #INT
	"charmed": 0, #INT relacionar con turnos
	"wounds":0, # INT Relacionar con turnos
	"stasis":0, #INT
	"sealed":0, #INT
	"speed":0, #FLOAT
	"charged":0, #INT
}

func process_effect(effect_name: String, params: Dictionary) -> void:
	match effect_name:
			#En todos los parametros se recibe target dado que afecta a alguien (tanto al jugador como a la maquina)
		"daño":
			apply_damage(params) #Se reciben damage 
		"sanación":
			apply_healing(params) #Se recibe heal 
		"escudo":
			apply_shield(params) #se recibe shield 
		"quemadura":
			apply_burn(params) #Se recibe damage y turn
		"aturdimiento":
			apply_stun(params) #Se recibe turn
		"silencio":
			apply_silence(params) #Se recibe turn
		"robo_de_vida":
			apply_life_steal(params) #Se recibe damage, percent y life_steal
		"favor_divino":
			apply_divine_favor(params) #No se recibe ninguna variable ma que target
		"neutralizado":
			apply_neutralized(params)  #Se recibe unicamente target (mismo caso anterior)
		"reflejo":
			apply_reflection(params) #Se recibe percent
		"desestabilizado":
			apply_destabilisation(params) #Se recibe reduction
		"ira":
			apply_rage(params) #Se recibe damage_increase y defense_reduction
		"espera_rápida":
			apply_espera_rapida(params) #Se recibe turns
		"encantado":
			apply_charmed(params) #Se recibe target
		"heridas_graves":
			apply_wounds(params) #Se recibe target
		"absorción":
			apply_absorption(params) #Se recibe percent
		"estasis":
			apply_stasis(params) #Se recibe turns
		"sellado":
			apply_sealed(params) #Se recibe turns
		"rápido":
			apply_speed(params) #Se recibe turns y speed
		"cargado":
			apply_charge(params) #Se recibe percent
		"encanto_de_maná":
			apply_mana_charm(params)  #Se recibe percent
		"barrera_de_maná":
			apply_mana_barrier(params) #Se recibe percent 


# Daño "plano"
func apply_damage(params: Dictionary) -> void:
	var damage = params.get("damage", 0)
	var target = params.get("target", null)
	if target:
		target.take_damage(damage)

# healing 
func apply_healing(params: Dictionary) -> void:
	var heal_amount = params.get("heal", 0)
	var target = params.get("target", null)
	if target:
		target.heal(heal_amount)

# Shielding
func apply_shield(params: Dictionary) -> void:
	var shield_amount = params.get("shield", 0)
	var target = params.get("target", null)
	if target:
		target.add_shield(shield_amount)

# Burn
func apply_burn(params: Dictionary) -> void:
	var burn_damage = params.get("damage", 0)
	var turns = params.get("turns", 1)
	var target = params.get("target", null)
	if target:
		target.add_effect("burn", {"damage": burn_damage, "turns": turns}) #crearle una sub-categoria

# stun
func apply_stun(params: Dictionary) -> void:
	var turns = params.get("turns", 1)
	var target = params.get("target", null)
	if target:
		target.add_effect("stunned", {"turns": turns}) #crearle una sub-categoria

# Silence lowie
func apply_silence(params: Dictionary) -> void:
	var turns = params.get("turns", 1)
	var target = params.get("target", null)
	if target:
		target.add_effect("silenced", {"turns": turns}) #crearle una sub-categoria

# Life Steal
func apply_life_steal(params: Dictionary) -> void:
	var damage = params.get("damage", 0)
	var life_steal_percent = params.get("percent", 0.0)
	var user = params.get("life_steal", null)
	if user:
		var healed = damage * life_steal_percent
		user.heal(healed)

# Divine Avor (o favior?)
func apply_divine_favor(params: Dictionary) -> void:
	var target = params.get("target", null)
	if target:
		target.remove_negative_effects()

# Neutralize
func apply_neutralized(params: Dictionary) -> void:
	var target = params.get("target", null)
	if target:
		target.remove_positive_effects()

# Reflect
func apply_reflection(params: Dictionary) -> void:
	var reflect_percent = params.get("percent", 0.0)
	var target = params.get("target", null)
	if target:
		target.add_effect("reflect", {"percent": reflect_percent})

# Desestabilizar (odio el ingles)
func apply_destabilisation(params: Dictionary) -> void:
	var dodge_reduction = params.get("reduction", 0.0)
	var target = params.get("target", null)
	if target:
		target.reduce_dodge_chance(dodge_reduction)

# Rage (Totoro)
func apply_rage(params: Dictionary) -> void:
	var damage_increase = params.get("damage_increase", 0.0)
	var defense_reduction = params.get("defense_reduction", 0.0)
	var user = params.get("target", null)
	if user:
		user.add_effect("rage", {"damage_increase": damage_increase, "defense_reduction": defense_reduction})

# Espera Rapida (sugiero cambiarlo por Fast Turn o algo algo asi dado que no existe el termino "Esperar Rapido")
func apply_espera_rapida(params: Dictionary) -> void:
	var turns = params.get("turns", 0)
	var target = params.get("target", null)
	if target:
		target.add_effect("espera_rapida", {"turns": turns})

# Encantado de conocerlo
func apply_charmed(params: Dictionary) -> void:
	var target = params.get("target", null)
	if target:
		target.add_effect("charmed", {})

# Heridas Graves (no quieren poner corta curas tambien? fanaticos del lol)
func apply_wounds(params: Dictionary) -> void:
	var target = params.get("target", null)
	if target:
		target.add_effect("wounds", {})

# Función para absorción
func apply_absorption(params: Dictionary) -> void:
	var absorb_percent = params.get("percent", 0.0)
	var target = params.get("target", null)
	if target:
		target.add_effect("absorption", {"percent": absorb_percent})

# Estasis
func apply_stasis(params: Dictionary) -> void:
	var turns = params.get("turns", 1)
	var target = params.get("target", null)
	if target:
		target.add_effect("stasis", {"turns": turns}) #crearle una sub-categoria

# Sello
func apply_sealed(params: Dictionary) -> void:
	var target = params.get("target", null)
	if target:
		target.add_effect("sealed", {})

# Velocidad relacionada a la chance de esquive
func apply_speed(params: Dictionary) -> void:
	var speed_increase = params.get("percent", 0.0)
	var target = params.get("target", null)
	if target:
		target.add_effect("speed", {"percent": speed_increase})

# Cargado = +Chance critica (NO daño critico, chance)
func apply_charge(params: Dictionary) -> void:
	var crit_increase = params.get("percent", 0.0)
	var target = params.get("target", null)
	if target:
		target.add_effect("charged", {"percent": crit_increase})

# Encantado de conocerlo (esta vez con maná)
func apply_mana_charm(params: Dictionary) -> void:
	var percent = params.get("percent", 0.0)
	var target = params.get("target", null)
	if target:
		target.add_effect("mana_charm", {"percent": percent})

# Bari Bari no mi 
func apply_mana_barrier(params: Dictionary) -> void:
	var target = params.get("target", null)
	if target:
		target.add_effect("mana_barrier",)
		target.take_damage("mana") #no se si lo hice bien, pero quiero que el daño descuente mana en lugar de vida xd
=======
	
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
		"life_steal":
			apply_life_steal(target, NoE, secondary_target, percent_life_steal) #Se recibe damage, percent y life_steal
		"divine_favor":
			apply_divine_favor(target) #No se recibe ninguna variable ma que target
		"neutralised":
			apply_neutralized(target)  #Se recibe unicamente target (mismo caso anterior)
		"reflected":
			apply_reflection(target, NoE) #Se recibe percent
		"destabilisation":
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

# Flat damage
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
>>>>>>> 5fa470b115cfe4fef460bb763dee86c5350a8a69
