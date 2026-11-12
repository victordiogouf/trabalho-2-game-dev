extends Node2D

func _ready() -> void:
	$EnemyArea.connect("enemies_ready", on_enemies_ready)

func on_enemies_ready(enemies: Array[Node]) -> void:
	for enemy in enemies:
		enemy.connect("collision_with_player", on_enemy_collision)
	
func on_enemy_collision(enemy: GameState.Enemy) -> void:
	GameState.collided_enemy = enemy
	# transition between scenes
	
func _process(delta: float) -> void:
	pass
