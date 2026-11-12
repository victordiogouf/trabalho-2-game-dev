class_name EnemyArea
extends Node

signal enemies_ready

enum EnemyType {
	oni,
	banshee,
	medusa
}

@export var min_rect: Vector2
@export var max_rect: Vector2
@export var min_level: int
@export var max_level: int
@export var num_enemies: int
@export var enemy_types: Array[EnemyType]
@export var enemy_scene: PackedScene

func spawn_enemy() -> Node:
	var enemy = enemy_scene.instantiate()
	enemy.min_rect = min_rect
	enemy.max_rect = max_rect
	enemy.type = enemy_types[randi_range(0, enemy_types.size() - 1)]
	enemy.min_level = min_level
	enemy.max_level = max_level
	add_child(enemy)
	return enemy
	
func _ready() -> void:
	var enemies: Array[Node] = []
	
	for i in range(num_enemies):
		var enemy = spawn_enemy()
		enemies.append(enemy)
	
	enemies_ready.emit(enemies)
