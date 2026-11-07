extends Node

enum ElementalType {
	Fire,
	Ice,
	Electricity,
	Force,
	Almighty,
	Expel,
	Death
}

class Skill:
	var name: String

enum Affinity {
	weak,
	resist,
	immune,
	repel,
	drain
}

class ElementalAffinity:
	var type: ElementalType
	var affinity: Affinity

class Character:
	var max_hp: int
	var hp: int
	var max_mp: int
	var mp: int
	var strength: int
	var magic: int
	var vitality: int
	var agility: int
	var level: int
	var experience: int
	var name: String
	var back_sprite: Texture2D
	var skills: Array[Skill]
	var elemental_affinities: Array[ElementalAffinity] # Não especificado = afinidade normal

class Monster extends Character:
	var front_sprite: Texture2D
	
	func exp_reward() -> int:
		return self.level * 100

var player = Character.new()

enum Direction {
	left,
	right
}

var last_player_position: Vector2
var last_player_facing_direction: Direction
