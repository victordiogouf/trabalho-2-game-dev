extends CharacterBody2D

signal collision_with_player

enum EnemyType {
	oni,
	banshee,
	medusa
}

var speed := 20.0
var min_rect: Vector2
var max_rect: Vector2
var type: EnemyType
var min_level: int
var max_level: int

var direction: Vector2

var data: GameState.Enemy

func _ready() -> void:
	direction.x = randf()
	direction.y = randf()
	direction = direction.normalized()
	position = Vector2(randf_range(min_rect.x, max_rect.x), randf_range(min_rect.y, max_rect.y))
	
	match type:
		EnemyType.oni: 
			data = GameState.create_oni(min_level, max_level)
		EnemyType.banshee: 
			data = GameState.create_banshee(min_level, max_level)
		EnemyType.medusa: 
			data = GameState.create_medusa(min_level, max_level)

func _physics_process(delta: float) -> void:
	if position.x < min_rect.x:
		direction.x = abs(direction.x)
	if position.x > max_rect.x:
		direction.x = -abs(direction.x)
		
	if position.y < min_rect.y:
		direction.y = abs(direction.y)
	if position.y > max_rect.y:
		direction.y = -abs(direction.y)
	
	velocity = direction * speed

	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		
		if body.is_in_group("player"):
			#Enemy collided with player
			collision_with_player.emit(data)
