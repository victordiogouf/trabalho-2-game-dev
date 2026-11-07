extends Node

var player_level := 0
var player_exp := 0

enum Direction {
	left,
	right
}

var last_player_position: Vector2
var last_player_facing_direction: Direction
