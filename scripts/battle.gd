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
	var atlas := AtlasTexture.new()
	atlas.atlas = GameState.collided_enemy.front_sprite
	var frame = randi_range(0, 9)
	atlas.region = Rect2(frame * 16, 0, 16, 32)
	$Enemy.texture = atlas
	$Enemy.scale = Vector2(10, 10)
	if GameState.collided_enemy.agility()>GameState.player.agility():
		enemyturn=true
		playerturn=false
		await get_tree().create_timer(2.0).timeout
		$Icons.text="Enemy Turn"
	else:
		playerturn=true
		enemyturn=false
		await get_tree().create_timer(2.0).timeout
		$Icons.text="Player Turn"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Stats/Player/HP.text=str(GameState.player.hp)+"/"+str(GameState.player.max_hp())+" HP"
	$Stats/Player/MP.text=str(GameState.player.mp)+"/"+str(GameState.player.max_mp())+" MP"
	$Stats/Enemy/HP.text=str(GameState.collided_enemy.hp)+"/"+str(GameState.collided_enemy.max_hp())+" HP"
	$Stats/Enemy/MP.text=str(GameState.collided_enemy.mp)+"/"+str(GameState.collided_enemy.max_mp())+" MP"
	if GameState.collided_enemy.hp<=0:
		get_tree().change_scene_to_packed(GameState.last_scene)
		return
	if enemyturn:
		enemy_turn()

func enemy_turn() -> void:
	enemyturn = false
	$Icons.text="Enemy Turn"
	await get_tree().create_timer(5.0).timeout

	GameState.player.hp -= GameState.collided_enemy.strength() * 0.5

	playerturn = true
	$Icons.text="Player Turn"
func _on_attack_pressed() -> void:
	if playerturn:
		GameState.collided_enemy.hp-=GameState.player.strength()
		enemyturn=true
		playerturn=false


func _on_skill_1_pressed() -> void:
	var skill = GameState.player.skills[0]
	var enemy = GameState.collided_enemy
	var damage = GameState.player.skills[0].power/10

	var found_affinity = false

	for affinity in enemy.elemental_affinities:
		if skill.type == affinity.type:
			found_affinity = true

			if affinity.affinity == GameState.Affinity.weak:
				damage *= 2

			break
	if playerturn:
		enemy.hp -= damage
		GameState.player.mp -= 4
		enemyturn=true
		playerturn=false

func _on_skill_2_pressed() -> void:
	var skill = GameState.player.skills[1]
	var enemy = GameState.collided_enemy
	var damage = GameState.player.skills[1].power/10

	var found_affinity = false

	for affinity in enemy.elemental_affinities:
		if skill.type == affinity.type:
			found_affinity = true

			if affinity.affinity == GameState.Affinity.weak:
				damage *= 2

			break
	if playerturn:
		enemy.hp -= damage
		GameState.player.mp -= 4
		enemyturn=true
		playerturn=false


func _on_skill_3_pressed() -> void:
	var skill = GameState.player.skills[2]
	var enemy = GameState.collided_enemy
	var damage = GameState.player.skills[2].power/10

	var found_affinity = false

	for affinity in enemy.elemental_affinities:
		if skill.type == affinity.type:
			found_affinity = true

			if affinity.affinity == GameState.Affinity.weak:
				damage *= 2

			break
	if playerturn:
		enemy.hp -= damage
		GameState.player.mp -= 4
		enemyturn=true
		playerturn=false

func _on_skill_4_pressed() -> void:
	var skill = GameState.player.skills[3]
	var enemy = GameState.collided_enemy
	var damage = GameState.player.skills[3].power/10

	var found_affinity = false

	for affinity in enemy.elemental_affinities:
		if skill.type == affinity.type:
			found_affinity = true

			if affinity.affinity == GameState.Affinity.weak:
				damage *= 2

			break
	if playerturn:
		enemy.hp -= damage
		GameState.player.mp -= 4
		enemyturn=true
		playerturn=false
