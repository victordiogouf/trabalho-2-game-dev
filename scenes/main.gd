extends Node2D
func _ready() -> void:
	if GameState.player == null:
		GameState.player = GameState.create_player()
	$Player.position=GameState.last_player_position
	$Player.temporary_invincibility()
func on_enemy_collision(enemy: Node) -> void:
	GameState.collided_enemy = enemy.data
	GameState.last_player_position=$Player.position
	enemy.queue_free.call_deferred()
	GameState.last_scene = load("res://scenes/main.tscn")
	get_tree().change_scene_to_file.call_deferred("res://scenes/battle.tscn")

func _on_enemies_ready(enemies: Array[Node]) -> void:
	for enemy in enemies:
		enemy.connect("collision_with_player", on_enemy_collision)
