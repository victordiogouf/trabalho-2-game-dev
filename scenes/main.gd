extends Node2D
func _ready() -> void:
	if GameState.player == null:
		GameState.player = GameState.create_player()
func on_enemy_collision(enemy: Node) -> void:
	GameState.collided_enemy = enemy.data
	enemy.queue_free.call_deferred()
	GameState.last_scene = get_tree().current_scene
	get_tree().change_scene_to_file.call_deferred("res://scenes/battle.tscn")

func _on_enemies_ready(enemies: Array[Node]) -> void:
	for enemy in enemies:
		enemy.connect("collision_with_player", on_enemy_collision)
