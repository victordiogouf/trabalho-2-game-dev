extends Node

enum ElementalType {
	fire,
	ice,
	electricity,
	force,
	death
}

class Skill:
	var name: String
	var power: int # reduces mp based on power
	var type: ElementalType

func create_flamethrower() -> Skill:
	var skill := Skill.new()
	skill.name = "Flamethrower"
	skill.power = 90
	skill.type = ElementalType.fire
	return skill

func create_ice_beam() -> Skill:
	var skill := Skill.new()
	skill.name = "Ice Beam"
	skill.power = 100
	skill.type = ElementalType.ice
	return skill
	
func create_thunder() -> Skill:
	var skill := Skill.new()
	skill.name = "Thunder"
	skill.power = 110
	skill.type = ElementalType.electricity
	return skill

func create_zan() -> Skill:
	var skill := Skill.new()
	skill.name = "Zan"
	skill.power = 150
	skill.type = ElementalType.force
	return skill
	
func create_mudo() -> Skill:
	var skill := Skill.new()
	skill.name = "Mudo"
	skill.power = 60
	skill.type = ElementalType.death
	return skill

enum Affinity {
	weak,
	resist,
	immune
}

class ElementalAffinity:
	var type: ElementalType
	var affinity: Affinity

class Character:
	func calculate_stat(base: int) -> int:
		return (2*base + 3*level) / 100 + 5
		
	var base_hp: int
	var base_mp: int
	var base_strength: int
	var base_magic: int
	var base_agility: int
	
	func max_hp() -> int:
		return (2 * base_hp + 5 * level) / 100 + level + 10
	func max_mp() -> int:
		return (2 * base_mp + 4 * level) / 100 + level + 10
	
	var hp: int
	var mp: int
	
	func strength() -> int:
		return calculate_stat(base_strength)
	func magic() -> int:
		return calculate_stat(base_magic)
	func agility() -> int:
		return calculate_stat(base_agility)
		
	var level: int
	var name: String
	var skills: Array[Skill]
	
class Player extends Character:
	var back_sprite: Texture2D

class Enemy extends Character:
	var front_sprite: Texture2D
	var elemental_affinities: Array[ElementalAffinity] # Não especificado = afinidade normal
	
	func defeat_reward() -> int:
		return log(level)/log(10) + 1

func create_player() -> Player:
	var player := Player.new()
	player.base_hp = 100
	player.base_mp = 100
	player.base_strength = 100
	player.base_magic = 100
	player.base_agility = 100
	player.level = 10
	player.hp = player.max_hp()
	player.mp = player.max_mp()
	player.name = "Player"
	player.skills = []
	player.skills.append(create_flamethrower())
	player.skills.append(create_mudo())
	player.skills.append(create_ice_beam())
	player.skills.append(create_zan())
	player.back_sprite = preload("res://tela_ui/personagem_batalha.png")
	return player
	
# boss overworld
func create_oni(min_level: int, max_level: int) -> Enemy:
	var enemy := Enemy.new()
	enemy.base_hp = 150
	enemy.base_mp = 90
	enemy.base_strength = 110
	enemy.base_magic = 80
	enemy.base_agility = 90
	enemy.level = randi_range(min_level, max_level)
	enemy.hp = enemy.max_hp()
	enemy.mp = enemy.max_mp()
	enemy.name = "Oni"
	enemy.skills = []
	enemy.skills.append(create_ice_beam())
	enemy.skills.append(create_zan())
	enemy.front_sprite = preload("res://boss_batalha.png")
	enemy.elemental_affinities = []
	
	var affinity := ElementalAffinity.new()
	affinity.type = ElementalType.fire
	affinity.affinity = Affinity.weak
	enemy.elemental_affinities.append(affinity)
	return enemy
	
# BOss vagao
func create_banshee(min_level: int, max_level: int) -> Enemy:
	var enemy := Enemy.new()
	enemy.base_hp = 140
	enemy.base_mp = 120
	enemy.base_strength = 120
	enemy.base_magic = 100
	enemy.base_agility = 100
	enemy.level = randi_range(min_level, max_level)
	enemy.hp = enemy.max_hp()
	enemy.mp = enemy.max_mp()
	enemy.name = "Banshee"
	enemy.skills = []
	enemy.skills.append(create_thunder())
	enemy.skills.append(create_zan())
	enemy.front_sprite = preload("res://boss2_batalha.png")
	enemy.elemental_affinities = []
	
	var affinity := ElementalAffinity.new()
	affinity.type = ElementalType.force
	affinity.affinity = Affinity.weak
	enemy.elemental_affinities.append(affinity)
	
	affinity = ElementalAffinity.new()
	affinity.type = ElementalType.electricity
	affinity.affinity = Affinity.immune
	enemy.elemental_affinities.append(affinity)
	
	return enemy

# Inimigo padrao
func create_medusa(min_level: int, max_level: int) -> Enemy:
	var enemy := Enemy.new()
	enemy.base_hp = 90
	enemy.base_mp = 80
	enemy.base_strength = 90
	enemy.base_magic = 70
	enemy.base_agility = 80
	enemy.level = randi_range(min_level, max_level)
	enemy.hp = enemy.max_hp()
	enemy.mp = enemy.max_mp()
	enemy.name = "Medusa"
	enemy.skills = []
	enemy.skills.append(create_thunder())
	enemy.skills.append(create_zan())
	enemy.front_sprite = preload("res://inimigo_base_overworld.png")
	enemy.elemental_affinities = []
	
	var affinity := ElementalAffinity.new()
	affinity.type = ElementalType.electricity
	affinity.affinity = Affinity.weak
	enemy.elemental_affinities.append(affinity)
	return enemy

enum Direction {
	left,
	right
}

# last scene related info
var last_scene: PackedScene
var last_player_position: Vector2=Vector2(56,520)
var last_player_facing_direction: Direction

var defeated_first_boss := false
var defeated_second_boss := false

var collided_enemy: Enemy
var player: Player
