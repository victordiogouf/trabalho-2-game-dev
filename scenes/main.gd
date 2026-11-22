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


func _on_door_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and GameState.defeated_first_boss:
		$Player.process_mode = Node.PROCESS_MODE_DISABLED
		$"plataforma/objetos/porta_vagão".play()
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://vagao_interior.tscn")
