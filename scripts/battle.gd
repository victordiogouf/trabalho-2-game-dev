extends Node
var playerturn:bool
var enemyturn:bool
func _ready() -> void:
	$Fight/Skill1.text="Flamethrower"
	$Fight/Skill2.text="Mudo"
	$Fight/Skill3.text="Ice Beam"
	$Fight/Skill4.text="Zan"
	$Stats/Player/HP.text=str(GameState.player.hp)+"/"+str(GameState.player.max_hp())+" HP"
	$Stats/Player/MP.text=str(GameState.player.mp)+"/"+str(GameState.player.max_mp())+" MP"
	$Stats/Enemy/HP.text=str(GameState.collided_enemy.hp)+"/"+str(GameState.collided_enemy.max_hp())+" HP"
	$Stats/Enemy/MP.text=str(GameState.collided_enemy.mp)+"/"+str(GameState.collided_enemy.max_mp())+" MP"
	if GameState.collided_enemy.agility()>GameState.player.agility():
		enemyturn=true
		playerturn=false
	else:
		playerturn=true
		enemyturn=false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Stats/Player/HP.text=str(GameState.player.hp)+"/"+str(GameState.player.max_hp())+" HP"
	$Stats/Player/MP.text=str(GameState.player.mp)+"/"+str(GameState.player.max_mp())+" MP"
	$Stats/Enemy/HP.text=str(GameState.collided_enemy.hp)+"/"+str(GameState.collided_enemy.max_hp())+" HP"
	$Stats/Enemy/MP.text=str(GameState.collided_enemy.mp)+"/"+str(GameState.collided_enemy.max_mp())+" MP"


func _on_attack_pressed() -> void:
	GameState.collided_enemy.hp-=GameState.player.strength()


func _on_skill_1_pressed() -> void:
	var skill = GameState.player.skills[0]
	var enemy = GameState.collided_enemy
	var damage = GameState.player.magic()

	var found_affinity = false

	for affinity in enemy.elemental_affinities:
		if skill.type == affinity.type:
			found_affinity = true

			if affinity.affinity == GameState.Affinity.weak:
				damage *= 2

			break

	enemy.hp -= damage
	GameState.player.mp -= 4

func _on_skill_2_pressed() -> void:
	GameState.collided_enemy.hp-=GameState.player.magic()
	GameState.player.mp-=3



func _on_skill_3_pressed() -> void:
	GameState.collided_enemy.hp-=GameState.player.magic()
	GameState.player.mp-=5


func _on_skill_4_pressed() -> void:
	GameState.collided_enemy.hp-=GameState.player.magic()
	GameState.player.mp-=6
