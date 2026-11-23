extends Node2D

var collision := false

func _ready() -> void:
	
	collision = false

	if GameState.player == null:
		GameState.player = GameState.create_player()

	#$Player.position = GameState.last_player_position
	$Player/Camera2D.make_current()
	$Player.temporary_invincibility()
	
func on_enemy_collision(enemy: Node) -> void:
	if collision:
		return
	collision = true
	GameState.collided_enemy = enemy.data
	GameState.last_player_position=$Player.position
	enemy.queue_free.call_deferred()
	GameState.last_scene = load("res://vagao_interior.tscn")
	get_tree().change_scene_to_file.call_deferred("res://scenes/battle.tscn")

func _on_enemy_area_boss_enemies_ready(enemies: Array[Node]) -> void:
	for enemy in enemies:
		enemy.connect("collision_with_player", on_enemy_collision)
func _process(delta: float) -> void:
	if GameState.defeated_second_boss==true:
		get_tree().change_scene_to_file("res://tela_ui_2/créditos.tscn")
