extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	start_turn_flow()

func pass_round():
	Global.rounds +=1
	Global.set_rounds(Global.rounds)
	await restore_players() # Add checks for rounds

func start_turn_flow():
	await player_action()
	await player_animation()
	await update_stats()
	await enemy_turn()
	await enemy_status()
	await enemy_action()
	await update_stats()
	await pass_round()
	start_turn_flow()

func player_status():
	print("Player animation status are running")
	await get_tree().create_timer(1.0).timeout

func player_action():
	print("Player did something")
	await get_tree().create_timer(1.0).timeout

func player_animation():
	print("Player animation is running")
	await get_tree().create_timer(1.0).timeout

func update_stats():
	print("Life/Mana is updating")
	await get_tree().create_timer(1.0).timeout

func enemy_turn():
	print("Enemy turn starts")
	await get_tree().create_timer(1.0).timeout

func enemy_status():
	print("Enemy animation status are running")
	await get_tree().create_timer(1.0).timeout

func enemy_action():
	print("Enemy did something")
	await get_tree().create_timer(1.0).timeout

func restore_players():
	print("Players stats get resetted to base")
